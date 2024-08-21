import 'package:flutter/material.dart';
import 'package:whatsapp/core/constants/colors.dart';

class MyMessageCard extends StatelessWidget {
  const MyMessageCard({
    super.key,
    required this.message,
    required this.time,
  });
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          margin: const EdgeInsets.all(6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: AppColor.tabColor,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 4,
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
                right: 6,
                bottom: 2,
                child: Row(
                  children: [
                    Text(
                      time,
                      style: const TextStyle(fontSize: 8),
                    ),
                    const Icon(
                      Icons.done,
                      size: 12.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
