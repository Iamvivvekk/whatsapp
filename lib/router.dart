import 'package:flutter/material.dart';
import 'package:whatsapp/core/common/widgets/error_screen.dart';
import 'package:whatsapp/core/constants/colors.dart';
import 'package:whatsapp/features/auth/screen/login_screen.dart';
import 'package:whatsapp/features/auth/screen/otp_screen.dart';
import 'package:whatsapp/features/auth/screen/user_information_screen.dart';
import 'package:whatsapp/features/select_contacts/screen/select_contacts_screen.dart';
import 'package:whatsapp/screens/mobile_chat_screen.dart';
import 'package:whatsapp/screens/mobile_layout.dart';

Route<dynamic> generateSettigs(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case OtpScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OtpScreen(verificationId: verificationId),
      );
    case UserInformationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserInformationScreen(),
      );
    case MobileScreenLayout.routeName:
      return MaterialPageRoute(
        builder: (context) => const MobileScreenLayout(),
      );
    case SelectContactScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SelectContactScreen(),
      );
      
    case MobileChatScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const MobileChatScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          backgroundColor: AppColor.messageColor,
          body: ErrorScreen(
            errorText: "Uh oh ! \nThis page doesn't exists...",
          ),
        ),
      );
  }
}
