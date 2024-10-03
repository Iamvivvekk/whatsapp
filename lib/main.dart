import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/core/common/widgets/error_screen.dart';
import 'package:whatsapp/core/common/widgets/splash_screen.dart';
import 'package:whatsapp/features/landing/screens/landing_screen.dart';
import 'package:whatsapp/features/auth/controller/auth_controller.dart';
import 'package:whatsapp/router.dart';
import 'package:whatsapp/screens/mobile_layout.dart';
import 'package:whatsapp/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   FirebaseAppCheck.instance.activate(
    androidProvider: kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity
  );
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Whatsapp clone',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      onGenerateRoute: (settings) => generateSettigs(settings),
      home: ref.watch(userDataAuthProvider).when(
        data: (user) {
          if (user == null) {
            return const LandingScreen();
          }
          return const MobileScreenLayout();
        },
        error: (error, stackTrack) {
          return ErrorScreen(errorText: error.toString());
        },
        loading: () {
          return const SplashScreen();
        },
      ),
    );
  }
}
