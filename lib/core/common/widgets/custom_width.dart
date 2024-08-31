import 'package:flutter/material.dart';

class HorizontalSpacer extends StatelessWidget {
  const HorizontalSpacer({
    super.key,
    this.width = 12,
  });
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
