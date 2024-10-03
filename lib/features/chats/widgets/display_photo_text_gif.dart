// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:whatsapp/core/common/enums/message_enums.dart';
import 'package:whatsapp/features/chats/widgets/display_video_item.dart';

class DisplayPhotoImageGif extends StatelessWidget {
  final String message;
  final MessageEnum messageEnum;
  const DisplayPhotoImageGif({
    super.key,
    required this.message,
    required this.messageEnum,
  });

  @override
  Widget build(BuildContext context) {
    return messageEnum == MessageEnum.text
        ? Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        : messageEnum == MessageEnum.image
            ? CachedNetworkImage(
                imageUrl: message,
              )
            : DisplayVideoItem(videoUrl: message);
  }
}
