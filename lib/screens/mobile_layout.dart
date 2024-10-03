import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/core/constants/colors.dart';
import 'package:whatsapp/core/utils/pick_image_video.dart';
import 'package:whatsapp/features/auth/controller/auth_controller.dart';
import 'package:whatsapp/features/select_contacts/screen/select_contacts_screen.dart';
import 'package:whatsapp/features/chats/widgets/contact_list.dart';
import 'package:whatsapp/features/status/screen/confirm_status_screen.dart';
import 'package:whatsapp/features/status/screen/status_contact_screen.dart';

class MobileScreenLayout extends ConsumerStatefulWidget {
  static const routeName = "/mobile-home";
  const MobileScreenLayout({super.key});

  @override
  ConsumerState<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends ConsumerState<MobileScreenLayout>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setOnlineStatus(true);
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        ref.read(authControllerProvider).setOnlineStatus(false);
    }
  }

  void navigateToSelectContactScreen(
      BuildContext context, TabController tabController) async {
    if (tabController.index == 0) {
      Navigator.pushNamed(context, SelectContactScreen.routeName);
    } else {
      File? image = await pickImageFromGallery(context);
      if (image != null && context.mounted) {
        Navigator.pushNamed(
          context,
          ConfirmStatusScreen.routeName,
          arguments: image,
        );
      }
    }
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
          bottom: TabBar(
            controller: tabController,
            labelColor: AppColor.textColor,
            unselectedLabelColor: AppColor.greyColor,
            indicatorColor: AppColor.tabColor,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            dividerHeight: 0,
            tabs: const [
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
        body: TabBarView(
          controller: tabController,
          children: const [
            ContactsList(),
            StatusContactScreen(),
            Center(
              child: Text("calls"),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              navigateToSelectContactScreen(context, tabController),
          child: const Icon(Icons.comment),
        ),
      ),
    );
  }
}
