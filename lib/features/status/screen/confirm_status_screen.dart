// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/core/constants/colors.dart';
import 'package:whatsapp/features/status/controller/status_controller.dart';

class ConfirmStatusScreen extends ConsumerWidget {
  const ConfirmStatusScreen({
    super.key,
    required this.file,
  });
  final File file;
  static const routeName = '/confirm-status-screen';

  void addStatus(BuildContext context, WidgetRef ref) {
    ref.read(statusControllerProvider).addStatus(file, context);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: Image.file(file),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addStatus(context, ref),
        backgroundColor: AppColor.tabColor,
        child: const Icon(
          Icons.done,
          color: AppColor.textColor,
          size: 24,
        ),
      ),
    );
  }
}
