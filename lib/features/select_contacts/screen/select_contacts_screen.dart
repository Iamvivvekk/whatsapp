import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/core/common/widgets/error_screen.dart';
import 'package:whatsapp/core/common/widgets/loader.dart';
import 'package:whatsapp/core/constants/colors.dart';
import 'package:whatsapp/core/constants/photo_urls.dart';
import 'package:whatsapp/features/select_contacts/controller/select_contact_controller.dart';

class SelectContactScreen extends ConsumerWidget {
  static const String routeName = "/select-contacts";
  const SelectContactScreen({super.key});

  void selectContact(
      WidgetRef ref, BuildContext context, Contact selectedContact) {
    ref
        .read(selectContactControllerProvider)
        .selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Contact",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ref.watch(selectContactFutureProvider).when(
            data: (contacts) => ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return InkWell(
                  onTap: () => selectContact(ref, context, contact),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColor.backgroundColor,
                      foregroundImage: contact.photo != null
                          ? MemoryImage(contact.photo!)
                          : const CachedNetworkImageProvider(
                              profilePhotoUrl,
                            ),
                    ),
                    title: Text(
                      contact.displayName,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                );
              },
            ),
            error: (error, stackTrace) =>
                ErrorScreen(errorText: error.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}

class ConsumetWidget {}
