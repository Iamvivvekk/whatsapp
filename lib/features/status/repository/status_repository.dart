import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp/core/repositories/common_firebase_storage_repositories.dart';
import 'package:whatsapp/core/utils/show_snakebar.dart';
import 'package:whatsapp/models/status_model.dart';
import 'package:whatsapp/models/user_model.dart';

final statusRepositoryProvider = Provider(
  (ref) => StatusRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
    ref: ref,
  ),
);

class StatusRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final ProviderRef ref;
  StatusRepository({
    required this.firestore,
    required this.auth,
    required this.ref,
  });

  Future<void> uploadStatus(
      {required String userName,
      required String profilePic,
      required String phoneNumber,
      required File statusImage,
      required BuildContext context}) async {
    try {
      var statusId = const Uuid().v1();
      String uid = auth.currentUser!.uid;
      List<Contact> contacts = [];
      String imageUrl = await ref
          .read(commonFirebaseStorageRepositoriesProvider)
          .storeFileToFirebaseStorage(
            "status/$statusId$uid",
            statusImage,
          );
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(
          withProperties: true,
          withPhoto: true,
        );
      }

      List<String> uidWhoCanSee = [];

      for (int i = 0; i < contacts.length; i++) {
        var userDataFirebase = await firestore
            .collection('users')
            .where(
              'phoneNumber',
              isEqualTo: contacts[i].phones[0].number.replaceAll(" ", ""),
            )
            .get();

        if (userDataFirebase.docs.isNotEmpty) {
          var userData = UserModel.fromMap(userDataFirebase.docs[0].data());
          uidWhoCanSee.add(userData.uid);
        }
      }

      List<String> statusImageUrls = [];

      var statusSnapshots = await firestore
          .collection('status')
          .where('uid', isEqualTo: auth.currentUser!.uid)
          .get();

      if (statusSnapshots.docs.isNotEmpty) {
        Status status = Status.fromMap(statusSnapshots.docs[0].data());
        statusImageUrls = status.photoUrl;
        statusImageUrls.add(imageUrl);
        await firestore
            .collection('status')
            .doc(statusSnapshots.docs[0].id)
            .update({
          'photoUrl': statusImageUrls,
        });
        return;
      } else {
        statusImageUrls = [imageUrl];
      }
      Status status = Status(
        uid: uid,
        username: userName,
        phoneNumber: phoneNumber,
        photoUrl: statusImageUrls,
        createdAt: DateTime.now(),
        profilePic: profilePic,
        statusId: statusId,
        whoCanSee: uidWhoCanSee,
      );

      await firestore.collection('status').doc(statusId).set(status.toMap());
    } catch (e) {
      if (context.mounted) showSnackbar(context, e.toString());
    }
  }
}
