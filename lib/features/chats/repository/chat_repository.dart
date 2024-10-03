import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp/core/common/enums/message_enums.dart';
import 'package:whatsapp/core/common/providers/message_reply_provider.dart';
import 'package:whatsapp/core/repositories/common_firebase_storage_repositories.dart';
import 'package:whatsapp/core/utils/show_snakebar.dart';
import 'package:whatsapp/models/chats_model.dart';
import 'package:whatsapp/models/message_model.dart';
import 'package:whatsapp/models/user_model.dart';

final chatRepositoryProvider = Provider((ref) {
  return ChatRepository(
    firebaseFirestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  );
});

class ChatRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth auth;
  ChatRepository({
    required this.firebaseFirestore,
    required this.auth,
  });

  Stream<List<ChatContactsModel>> getChatContacts() {
    return firebaseFirestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .snapshots()
        .asyncMap(
      (event) async {
        List<ChatContactsModel> contacts = [];

        for (var document in event.docs) {
          var chatContact = ChatContactsModel.fromMap(document.data());
          var userData = await firebaseFirestore
              .collection("users")
              .doc(chatContact.contactId)
              .get();

          var user = UserModel.fromMap(userData.data()!);
          contacts.add(
            ChatContactsModel(
              name: user.name,
              profilePic: user.profilePic,
              contactId: chatContact.contactId,
              lastMessage: chatContact.lastMessage,
              timeSent: chatContact.timeSent,
            ),
          );
        }
        return contacts;
      },
    );
  }

  Stream<List<Message>> getChatStream(String receiverUserId) {
    return firebaseFirestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .doc(receiverUserId)
        .collection("messages")
        .orderBy("timeSent")
        .snapshots()
        .map((event) {
      List<Message> messages = [];
      for (var document in event.docs) {
        messages.add(Message.fromMap(document.data()));
      }
      return messages;
    });
  }

  Future<void> _saveDataToContactSubcollection(
    String text,
    UserModel senderUserData,
    UserModel receiverUserData,
    DateTime timeSent,
    String receiverUserId,
  ) async {
    ChatContactsModel receiverChatContact = ChatContactsModel(
      name: senderUserData.name,
      profilePic: senderUserData.profilePic,
      contactId: senderUserData.uid,
      lastMessage: text,
      timeSent: timeSent,
    );
    //users ->  receiver id -> chats -> current user id-> setData
    await firebaseFirestore
        .collection("users")
        .doc(receiverUserData.uid)
        .collection("chats")
        .doc(senderUserData.uid)
        .set(
          receiverChatContact.toMap(),
        );

    ChatContactsModel senderChatContact = ChatContactsModel(
      name: receiverUserData.name,
      profilePic: receiverUserData.profilePic,
      contactId: receiverUserData.uid,
      lastMessage: text,
      timeSent: timeSent,
    );

    //users -> current user id -> chats -> receiver id -> setData

    await firebaseFirestore
        .collection("users")
        .doc(senderUserData.uid)
        .collection("chats")
        .doc(receiverUserData.uid)
        .set(
          senderChatContact.toMap(),
        );
  }

  Future<void> _saveMessageToMessageSubCollection({
    required String receiverUserId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String username,
    required String receiverUserName,
    required MessageEnum messageType,
    required MessageReply? repliedMessage,
    required String senderUserName,
    required String recieverUserName,
  }) async {
    final message = Message(
      senderUserId: auth.currentUser!.uid,
      receiverId: receiverUserId,
      type: messageType,
      text: text,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
      repliedMessage: repliedMessage == null ? "" : repliedMessage.message,
      repliedTo: repliedMessage == null
          ? ""
          : repliedMessage.isMe
              ? senderUserName
              : receiverUserName,
      repliedMessageType: repliedMessage == null
          ? MessageEnum.text
          : repliedMessage.messageEnums,
    );

    // user ->sender id -> chats  ->  receiver id -> message -> message id -> store message

    await firebaseFirestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .doc(receiverUserId)
        .collection("messages")
        .doc(messageId)
        .set(message.toMap());

    // user ->  receiver id -> chats  -> sender id-> message -> message id -> store message

    await firebaseFirestore
        .collection("users")
        .doc(receiverUserId)
        .collection("chats")
        .doc(auth.currentUser!.uid)
        .collection("messages")
        .doc(messageId)
        .set(message.toMap());
  }

  Future<void> sendTextMessage({
    required BuildContext context,
    required String msgText,
    required String receiverUserId,
    required UserModel senderUser,
    required MessageReply? repliedMessage,
  }) async {
    try {
      DateTime timeSent = DateTime.now();
      UserModel receiverUserData;

      final userDataMap =
          await firebaseFirestore.collection("users").doc(receiverUserId).get();
      receiverUserData = UserModel.fromMap(userDataMap.data()!);

      final messageId = const Uuid().v1();

      _saveDataToContactSubcollection(
        msgText,
        senderUser,
        receiverUserData,
        timeSent,
        receiverUserId,
      );

      _saveMessageToMessageSubCollection(
        messageType: MessageEnum.text,
        messageId: messageId,
        receiverUserId: receiverUserId,
        receiverUserName: receiverUserData.name,
        text: msgText,
        timeSent: timeSent,
        username: senderUser.name,
        repliedMessage: repliedMessage,
        recieverUserName: receiverUserData.name,
        senderUserName: senderUser.name,
      );
    } catch (e) {
      if (context.mounted) {
        showSnackbar(context, e.toString());
      }
    }
  }

  Future<void> sendFileMessage({
    required BuildContext context,
    required File file,
    required String receiverUserId,
    required UserModel senderUserData,
    required ProviderRef ref,
    required MessageEnum messageEnum,
    required MessageReply? messageReply,
  }) async {
    try {
      DateTime timeSent = DateTime.now();
      var messageId = const Uuid().v1();

      var fileUrl = await ref
          .read(commonFirebaseStorageRepositoriesProvider)
          .storeFileToFirebaseStorage(
            'chat/${messageEnum.type}/${senderUserData.uid}/$receiverUserId/messages/$messageId',
            file,
          );
      UserModel receiverUserData;
      var userDataMap =
          await firebaseFirestore.collection("users").doc(receiverUserId).get();
      receiverUserData = UserModel.fromMap(userDataMap.data()!);

      String contactMessage;

      switch (messageEnum) {
        case MessageEnum.audio:
          contactMessage = '🔈Audio';
          break;
        case MessageEnum.video:
          contactMessage = '🎥 Video';
          break;

        case MessageEnum.image:
          contactMessage = '📷 Photo';
          break;
        case MessageEnum.gif:
          contactMessage = 'GIF';
          break;

        default:
          contactMessage = 'GIF';
          break;
      }

      _saveDataToContactSubcollection(
        contactMessage,
        senderUserData,
        receiverUserData,
        timeSent,
        receiverUserId,
      );

      _saveMessageToMessageSubCollection(
        receiverUserId: receiverUserId,
        text: fileUrl,
        timeSent: timeSent,
        messageId: messageId,
        username: senderUserData.name,
        receiverUserName: receiverUserData.name,
        messageType: messageEnum,
        repliedMessage: messageReply,
        recieverUserName: receiverUserData.name,
        senderUserName: senderUserData.name,
      );
    } on FirebaseException {
      rethrow;
    } catch (e) {
      if (context.mounted) {
        showSnackbar(context, e.toString());
      }
    }
  }

  void setChatSeenMessage(
    BuildContext context,
    String receiverUserId,
    String messageId,
  ) async {
    try {
      await firebaseFirestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("chats")
          .doc(receiverUserId)
          .collection("messages")
          .doc(messageId)
          .update(
        {
          'isSeen': true,
        },
      );

     await firebaseFirestore
          .collection("users")
          .doc(receiverUserId)
          .collection("chats")
          .doc(auth.currentUser!.uid)
          .collection("messages")
          .doc(messageId)
          .update(
        {
          'isSeen': true,
        },
      );
    } catch (e) {
      if (context.mounted) {
        showSnackbar(context, e.toString());
      }
    }
  }
}
