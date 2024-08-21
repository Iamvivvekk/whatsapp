import 'package:flutter/material.dart';
import 'package:whatsapp/core/constants/colors.dart';

class WebSearchBar extends StatelessWidget {
  const WebSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: Theme.of(context).textTheme.bodySmall,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          hintText: "Search ",
          prefixIcon: const Icon(
            Icons.search,
            color: AppColor.greyColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          fillColor: AppColor.mobileChatBoxColor,
          filled: true,
        ),
      ),
    );
  }
}
