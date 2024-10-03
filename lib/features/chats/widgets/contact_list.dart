import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp/core/common/widgets/loader.dart';
import 'package:whatsapp/features/chats/controller/chat_controller.dart';
import 'package:whatsapp/features/chats/screen/mobile_chat_screen.dart';
import 'package:whatsapp/core/constants/colors.dart';

class ContactsList extends ConsumerWidget {
  const ContactsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
        stream: ref.watch(chatControllerProvider).getChatContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final contactsData = snapshot.data![index];
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        MobileChatScreen.routeName,
                        arguments: {
                          "name": contactsData.name,
                          "uid": contactsData.contactId
                        },
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 22,
                          backgroundImage: CachedNetworkImageProvider(
                            contactsData.profilePic,
                          )),
                      title: Text(
                        contactsData.name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      subtitle: Text(
                        contactsData.lastMessage,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing:
                          Text(DateFormat.Hm().format(contactsData.timeSent)),
                    ),
                  ),
                  const Divider(
                    indent: 65,
                    endIndent: 8,
                    thickness: 0.0,
                    color: AppColor.dividerColor,
                    height: 0,
                  )
                ],
              );
            },
          );
        });
  }
}
