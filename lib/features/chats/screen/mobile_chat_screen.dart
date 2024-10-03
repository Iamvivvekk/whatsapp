// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/core/common/widgets/loader.dart';
import 'package:whatsapp/features/auth/controller/auth_controller.dart';

import 'package:whatsapp/features/chats/widgets/bottom_chat_field.dart';
import 'package:whatsapp/features/chats/widgets/chat_list.dart';
import 'package:whatsapp/models/user_model.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = "/mobile-chat";
  final String uid;
  final String name;

  const MobileChatScreen({
    super.key,
    required this.uid,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<UserModel>(
            stream: ref.watch(authControllerProvider).userDataById(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              final userData = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userData!.name.isEmpty
                        ? "User"
                        : "${userData.name[0].toUpperCase()}${userData.name.substring(1).toLowerCase()} ",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  userData.isOnline
                      ? Text(
                          "Online",
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      : Text(
                          "Offline",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                ],
              );
            }),
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
          Expanded(
              child: ChatList(
            receiverUserId: uid,
          )),
          BottomChatField(
            receiverUserId: uid,
          ),
        ],
      ),
    );
  }
}
