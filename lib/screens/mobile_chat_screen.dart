import 'package:flutter/material.dart';
import 'package:whatsapp/core/common/widgets/custom_width.dart';
import 'package:whatsapp/core/constants/colors.dart';
import 'package:whatsapp/widgets/web_chat_list.dart';

class MobileChatScreen extends StatelessWidget {
  static const String routeName = "/mobile-chat";

  const MobileChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "Last seen at 12:48 PM",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          const Expanded(child: ChatList()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: TextField(
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 3,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.emoji_emotions_outlined),
                        suffix: SizedBox(
                          width: 96,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(Icons.attach_file),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Icon(Icons.camera_alt),
                              ),
                            ],
                          ),
                        ),
                        filled: true,
                        fillColor: AppColor.searchBarColor,
                        border: _inputBorder(),
                        focusedBorder: _inputBorder(),
                      ),
                    ),
                  ),
                ),
                const HorizontalSpacer(),
                const CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColor.tabColor,
                  child: Icon(
                    Icons.send,
                    size: 22,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: const BorderSide(color: AppColor.searchBarColor),
    );
  }
}
