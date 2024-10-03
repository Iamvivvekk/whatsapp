import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/core/common/providers/message_reply_provider.dart';
import 'package:whatsapp/core/constants/colors.dart';
import 'package:whatsapp/features/chats/widgets/display_photo_text_gif.dart';

class MessageReplyPreview extends ConsumerWidget {
  const MessageReplyPreview({
    super.key,
  });

  void cancelReply(WidgetRef ref) {
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageReply = ref.watch(messageReplyProvider);
    return Container(
      padding: const EdgeInsets.all(8),
      width: MediaQuery.sizeOf(context).width * 0.85,
      decoration: BoxDecoration(
        color: AppColor.appBarColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  messageReply!.isMe ? 'Me' : 'Opposite',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              GestureDetector(
                onTap: () => cancelReply(ref),
                child: const Icon(
                  Icons.close_rounded,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: AppColor.lightTabColor,
                borderRadius: BorderRadius.circular(6)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: DisplayPhotoImageGif(
                message: messageReply.message,
                messageEnum: messageReply.messageEnums,
              ),
            ),
          )
        ],
      ),
    );
  }
}
