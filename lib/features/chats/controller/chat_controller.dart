import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/core/common/enums/message_enums.dart';
import 'package:whatsapp/core/common/providers/message_reply_provider.dart';
import 'package:whatsapp/features/auth/controller/auth_controller.dart';
import 'package:whatsapp/features/chats/repository/chat_repository.dart';
import 'package:whatsapp/models/chats_model.dart';
import 'package:whatsapp/models/message_model.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.read(chatRepositoryProvider);
  return ChatController(
    chatRepository: chatRepository,
    ref: ref,
  );
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;

  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  Stream<List<ChatContactsModel>> getChatContacts() {
    return chatRepository.getChatContacts();
  }

  Stream<List<Message>> getChatStream(String receiverUserId) {
    return chatRepository.getChatStream(receiverUserId);
  }

  void sendTextMessage({
    required BuildContext context,
    required String msgText,
    required String receiverUserId,
  }) {
    final messageReply = ref.read(messageReplyProvider);
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendTextMessage(
            context: context,
            msgText: msgText,
            receiverUserId: receiverUserId,
            senderUser: value!,
            repliedMessage: messageReply,
          ),
        );
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void sendFileMessage({
    required BuildContext context,
    required File file,
    required String receiverUserId,
    required MessageEnum messageEnum,
  }) {
    final messageReply = ref.read(messageReplyProvider);
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendFileMessage(
            context: context,
            file: file,
            receiverUserId: receiverUserId,
            messageEnum: messageEnum,
            ref: ref,
            senderUserData: value!,
            messageReply: messageReply,
          ),
        );

    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  void setMessageSeen(
    BuildContext context,
    String receiverUserId,
    String messageId,
  ) {
    ref
        .read(chatRepositoryProvider)
        .setChatSeenMessage(context, receiverUserId, messageId);
  }
}
