import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonFirebaseStorageRepositoriesProvider = Provider((ref) {
  return CommonFirebaseStorageRepositories(
    firebaseStorage: FirebaseStorage.instance,
  );
});

class CommonFirebaseStorageRepositories {
  final FirebaseStorage firebaseStorage;

  CommonFirebaseStorageRepositories({required this.firebaseStorage});

  Future<String>  storeFileToFirebaseStorage(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(
        file,
        SettableMetadata(
          contentType: "image/jpeg",
        ));
    TaskSnapshot snapshot = await uploadTask;
    String photoUrl = await snapshot.ref.getDownloadURL();
    return photoUrl;
  }
}
