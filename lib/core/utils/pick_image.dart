import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:whatsapp/core/utils/show_snakebar.dart';

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg'],
    );
    if (result != null) {
      image = File(result.files.single.path!);
      print("image is $image");
    }
  } catch (e) {
    if (context.mounted) {
      showSnackbar(context, e.toString());
    }
  }
  return image;
}
