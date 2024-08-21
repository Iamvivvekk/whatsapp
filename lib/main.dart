import 'package:flutter/material.dart';
import 'package:whatsapp/responsive.dart';
import 'package:whatsapp/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whatsapp clone',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      home: const ResponsiveLayout(),
    );
  }
}
