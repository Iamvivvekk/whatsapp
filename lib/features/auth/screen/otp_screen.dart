// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatsapp/core/common/widgets/custom_height.dart';
import 'package:whatsapp/core/constants/colors.dart';
import 'package:whatsapp/features/auth/controller/auth_controller.dart';

class OtpScreen extends ConsumerWidget {
  static const routeName = "/otp-validation";
  const OtpScreen({
    super.key,
    required this.verificationId,
  });
  final String verificationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verifying your phone number"),
        centerTitle: true,
        backgroundColor: AppColor.backgroundColor,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "We have sent an SMS with code",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColor.greyColor),
              ),
              const VerticalSpacer(),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.2),
                child: TextField(
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(letterSpacing: 8),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "------",
                    hintStyle: TextStyle(
                      letterSpacing: 12,
                      fontSize: 18,
                      color: AppColor.greyColor,
                    ),
                  ),
                  onChanged: (value) {
                    if (value.length == 6) {
                      ref.read(authControllerProvider).verifyOtp(
                            context: context,
                            verificationId: verificationId,
                            userOtp: value.trim(),
                          );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
