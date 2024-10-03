// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

import 'package:whatsapp/core/common/enums/message_enums.dart';
import 'package:whatsapp/features/chats/widgets/display_photo_text_gif.dart';

import '../../../core/constants/colors.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard({
    super.key,
    required this.message,
    required this.time,
    required this.messageEnum,
    required this.onRightSwipe,
    required this.repliedText,
    required this.userName,
    required this.repliedMessageType,
  });

  final String message;
  final String time;
  final MessageEnum messageEnum;
  final void Function(DragUpdateDetails)? onRightSwipe;
  final String repliedText;
  final String userName;
  final MessageEnum repliedMessageType;

  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      onRightSwipe: onRightSwipe,
      child: Align(
        alignment: Alignment.centerLeft,
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
            color: AppColor.appBarColor,
            child: Stack(
              children: [
                Padding(
                  padding: messageEnum == MessageEnum.image
                      ? const EdgeInsets.only(
                          top: 2,
                          right: 8,
                          bottom: 12,
                          left: 8,
                        )
                      : const EdgeInsets.only(
                          top: 2,
                          right: 8,
                          bottom: 12,
                          left: 8,
                        ),
                  child: DisplayPhotoImageGif(
                    message: message,
                    messageEnum: messageEnum,
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 2,
                  child: Text(
                    time.toString(),
                    style: const TextStyle(
                        fontSize: 8, fontWeight: FontWeight.bold),
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
