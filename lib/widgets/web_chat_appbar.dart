import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/core/constants/colors.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      height: MediaQuery.of(context).size.height * 0.077,
      color: AppColor.appBarColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                foregroundImage: CachedNetworkImageProvider(
                    "https://upload.wikimedia.org/wikipedia/commons/8/85/Elon_Musk_Royal_Society_%28crop1%29.jpg"),
              ),
              const SizedBox(width: 21),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Vivek Saroj",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text("Last seen at 12:48 PM",
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              )
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.video_call_outlined)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            ],
          )
        ],
      ),
    );
  }
}
