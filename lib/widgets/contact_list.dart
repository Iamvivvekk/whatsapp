import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/data/info.dart';
import 'package:whatsapp/screens/mobile_chat_screen.dart';
import 'package:whatsapp/core/constants/colors.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: info.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => const MobileChatScreen(),
                  ),
                );
              },
              child: ListTile(
                leading: CircleAvatar(
                    radius: 18,
                    backgroundImage: CachedNetworkImageProvider(
                      info[index]['profilePic'] as String,
                    )),
                title: Text(
                  info[index]['name'] as String,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  info[index]['message'] as String,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
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
  }
}
