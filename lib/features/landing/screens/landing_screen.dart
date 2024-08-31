import 'package:flutter/material.dart';
import 'package:whatsapp/core/common/widgets/custom_button.dart';
import 'package:whatsapp/core/common/widgets/custom_height.dart';
import 'package:whatsapp/core/constants/colors.dart';
import 'package:whatsapp/features/auth/screen/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const VerticalSpacer(height: 40),
            Text(
              "Welcome to WhatsApp",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Spacer(flex: 1),
            Image.asset(
              "assets/welcome.png",
              color: AppColor.lightTabColor,
              scale: 1.7,
            ),
            const Spacer(flex: 2),
            const Text(
              "Read our Privacy Policy. Tap \"Agree and Continue\" to accept the Terms of Service",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.greyColor,
                fontSize: 12,
              ),
            ),
            const VerticalSpacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width - 60,
              child: CustomElevatedButton(
                btnText: "AGREE AND CONTINUE",
                onTap: () => navigateToLoginScreen(context),
              ),
            ),
            const VerticalSpacer(height: 40),
          ],
        ),
      )),
    );
  }
}
