import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

import 'package:whatsapp/core/common/enums/message_enums.dart';
import 'package:whatsapp/core/constants/colors.dart';
import 'package:whatsapp/features/chats/widgets/display_photo_text_gif.dart';

class MyMessageCard extends StatelessWidget {
  const MyMessageCard({
    super.key,
    required this.message,
    required this.time,
    required this.messageEnum,
    required this.onLeftSwipe,
    required this.repliedText,
    required this.userName,
    required this.repliedMessageType,
    required this.isSeen,
  });
  final String message;
  final String time;
  final MessageEnum messageEnum;
  final void Function(DragUpdateDetails)? onLeftSwipe;
  final String repliedText;
  final String userName;
  final MessageEnum repliedMessageType;
  final bool isSeen;

  @override
  Widget build(BuildContext context) {
    final isReplying = repliedText.isNotEmpty;
    print('is seen is : $isSeen');
    return SwipeTo(
      onLeftSwipe: onLeftSwipe,
      child: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
            minWidth: 60,
          ),
          child: Card(
            margin: const EdgeInsets.all(6),
            shape: RoundedRectangleBorder(
              borderRadius: messageEnum != MessageEnum.image
                  ? BorderRadius.circular(12)
                  : BorderRadius.circular(8),
            ),
            color: AppColor.tabColor,
            child: Stack(
              children: [
                Padding(
                  padding: messageEnum != MessageEnum.image
                      ? const EdgeInsets.only(
                          top: 4,
                          right: 8,
                          bottom: 12,
                          left: 8,
                        )
                      : const EdgeInsets.only(
                          top: 4,
                          right: 4,
                          bottom: 14,
                          left: 4,
                        ),
                  child: Column(
                    children: [
                      if (isReplying) ...[
                        Text(
                          userName[0].toUpperCase() +
                              userName.substring(1).toLowerCase(),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: AppColor.backgroundColor.withOpacity(0.85),
                              borderRadius: BorderRadius.circular(8)),
                          child: DisplayPhotoImageGif(
                            message: repliedText,
                            messageEnum: repliedMessageType,
                          ),
                        ),
                      ],
                      DisplayPhotoImageGif(
                        message: message,
                        messageEnum: messageEnum,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 6,
                  bottom: 2,
                  child: Row(
                    children: [
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        isSeen ? Icons.done_all : Icons.done,
                        size: 14.0,
                        color: isSeen
                            ? const Color.fromARGB(255, 33, 243, 194)
                            : Colors.white60,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
