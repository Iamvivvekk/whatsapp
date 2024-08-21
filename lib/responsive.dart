import 'package:flutter/material.dart';
import 'package:whatsapp/screens/desktop_layout.dart';
import 'package:whatsapp/screens/mobile_layout.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return const DesktopLayout();
      } else {
        return const MobileLayout();
      }
    });
  }
}
