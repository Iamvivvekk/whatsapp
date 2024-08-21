// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard({
    super.key,
    required this.message,
    required this.time,
  });

  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          margin: const EdgeInsets.all(6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: AppColor.appBarColor,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 2,
                  right: 8,
                  bottom: 12,
                  left: 8,
                ),
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Positioned(
                right: 10,
                bottom: 2,
                child: Text(
                  time.toString(),
                  style: const TextStyle(fontSize: 8),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
