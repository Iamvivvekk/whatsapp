import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/core/common/widgets/custom_height.dart';
import 'package:whatsapp/core/constants/colors.dart';
import 'package:whatsapp/core/constants/photo_urls.dart';
import 'package:whatsapp/core/utils/pick_image.dart';
import 'package:whatsapp/features/auth/controller/auth_controller.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  static const routeName = "/user-information";
  const UserInformationScreen({super.key});

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  File? profileImage;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void navigateToHomeScreen() {
    ref.read(authControllerProvider).storeUserDataToFirebase(
          context: context,
          name: nameController.text.trim(),
          profilePic: profileImage,
         
        );
  }

  void pickImage() async {
    profileImage = await pickImageFromGallery(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  const VerticalSpacer(),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundColor: AppColor.backgroundColor,
                        backgroundImage: profileImage != null
                            ? FileImage(profileImage!)
                            : const CachedNetworkImageProvider(
                                profilePhotoUrl,
                              ),
                      ),
                      Positioned(
                        right: -8,
                        bottom: -8,
                        child: IconButton(
                          onPressed: pickImage,
                          icon: const Icon(Icons.add_a_photo),
                          color: AppColor.textColor,
                        ),
                      )
                    ],
                  ),
                  const VerticalSpacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        child: TextField(
                          controller: nameController,
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: const InputDecoration(
                            hintText: "Enter your name",
                            contentPadding: EdgeInsets.only(
                              left: 8.0,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: navigateToHomeScreen,
                        icon: const Icon(
                          Icons.done,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
