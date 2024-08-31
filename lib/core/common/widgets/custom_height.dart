import 'package:flutter/material.dart';

class VerticalSpacer extends StatelessWidget {
  const VerticalSpacer({
    super.key,
    this.height = 20,
  });
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
