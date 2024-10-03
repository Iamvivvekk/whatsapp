import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/core/utils/show_snakebar.dart';

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );
    if (result != null) {
      image = File(result.files.single.path!);
    }
  } catch (e) {
    if (context.mounted) {
      showSnackbar(context, e.toString());
    }
  }
  return image;
}

Future<File?> pickVideoFromGallery(BuildContext context) async {
  File? video;
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.video,
      compressionQuality: 70,
    );
    if (result != null) {
      video = File(result.files.single.path!);
    }
  } catch (e) {
    if (context.mounted) {
      showSnackbar(context, e.toString());
    }
  }

  return video;
}
