import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp/core/common/enums/message_enums.dart';
import 'package:whatsapp/core/common/providers/message_reply_provider.dart';
import 'package:whatsapp/core/common/widgets/loader.dart';
import 'package:whatsapp/features/chats/controller/chat_controller.dart';
import 'package:whatsapp/features/chats/widgets/my_message_card.dart';
import 'package:whatsapp/features/chats/widgets/sender_message_card.dart';

class ChatList extends ConsumerStatefulWidget {
  const ChatList({
    super.key,
    required this.receiverUserId,
  });
  final String receiverUserId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController scrollController = ScrollController();
  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void onMessageSwipe(
    String message,
    bool isMe,
    MessageEnum messageEnum,
  ) {
    ref.read(messageReplyProvider.notifier).update(
          (v) => MessageReply(
            message: message,
            isMe: isMe,
            messageEnums: messageEnum,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ref
            .watch(chatControllerProvider)
            .getChatStream(widget.receiverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          SchedulerBinding.instance.addPostFrameCallback(
            (_) {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            },
          );

          return ListView.builder(
            controller: scrollController,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];

              if (!messageData.isSeen &&
                  messageData.receiverId ==
                      FirebaseAuth.instance.currentUser!.uid) {
                ref.read(chatControllerProvider).setMessageSeen(
                      context,
                      widget.receiverUserId,
                      messageData.messageId,
                    );
              }
              if (messageData.senderUserId ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return MyMessageCard(
                  message: messageData.text,
                  messageEnum: messageData.type,
                  time: DateFormat.Hm().format(messageData.timeSent),
                  repliedText: messageData.repliedMessage,
                  userName: messageData.repliedTo,
                  repliedMessageType: messageData.repliedMessageType,
                  isSeen: messageData.isSeen,
                  onLeftSwipe: (dragUpdateDetails) => onMessageSwipe(
                    messageData.text,
                    true,
                    messageData.type,
                  ),
                );
              } else {
                return SenderMessageCard(
                  message: messageData.text,
                  messageEnum: messageData.type,
                  time: DateFormat.Hm().format(messageData.timeSent),
                  repliedMessageType: messageData.repliedMessageType,
                  repliedText: messageData.repliedMessage,
                  userName: messageData.repliedTo,
                  onRightSwipe: (dragUpdateDetails) => onMessageSwipe(
                    messageData.text,
                    false,
                    messageData.type,
                  ),
                );
              }
            },
          );
        });
  }
}
