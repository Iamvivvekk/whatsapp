import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/data/info.dart';
import 'package:whatsapp/core/constants/colors.dart';

class WebProfileBar extends StatelessWidget {
  const WebProfileBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.appBarColor,
        border: Border(
          right: BorderSide(color: AppColor.appBarColor),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.077,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundImage:
                  CachedNetworkImageProvider(info[0]['profilePic'] as String),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }
}
