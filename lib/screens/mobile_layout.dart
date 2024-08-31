import 'package:flutter/material.dart';
import 'package:whatsapp/core/constants/colors.dart';
import 'package:whatsapp/features/select_contacts/screen/select_contacts_screen.dart';
import 'package:whatsapp/widgets/contact_list.dart';

class MobileScreenLayout extends StatelessWidget {
  static const routeName = "/mobile-home";
  const MobileScreenLayout({super.key});

  void navigateToSelectContactScreen(BuildContext context) {
    Navigator.pushNamed(context, SelectContactScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WhatsApp'),
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
          bottom: const TabBar(
            labelColor: AppColor.textColor,
            unselectedLabelColor: AppColor.greyColor,
            indicatorColor: AppColor.tabColor,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            dividerHeight: 0,
            tabs: [
              Tab(
                text: "Chats",
              ),
              Tab(
                text: "Status",
              ),
              Tab(
                text: "Calls",
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          const ContactsList(),
          Center(
            child: Text(
              "status",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const Center(
            child: Text("calls"),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () => navigateToSelectContactScreen(context),
          child: const Icon(Icons.comment),
        ),
      ),
    );
  }
}
