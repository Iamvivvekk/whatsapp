import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/core/utils/show_snakebar.dart';
import 'package:whatsapp/models/user_model.dart';
import 'package:whatsapp/features/chats/screen/mobile_chat_screen.dart';

final selectContactRepositoryProvider = Provider((ref) {
  return SelectContactRepository(firebaseFirestore: FirebaseFirestore.instance);
});

class SelectContactRepository {
  final FirebaseFirestore firebaseFirestore;
  SelectContactRepository({required this.firebaseFirestore});

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(
          withProperties: true,
          withPhoto: true,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  Future<void> selectContact(
      Contact selectedContact, BuildContext context) async {
    try {
      bool isFound = false;
      var userCollection = await firebaseFirestore.collection("users").get();

      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        String selectedPhoneNumber =
            selectedContact.phones[0].number.replaceAll(" ", "");
        if (selectedPhoneNumber == userData.phoneNumber) {
          isFound = true;
          if (context.mounted) {
            Navigator.popAndPushNamed(
              context,
              MobileChatScreen.routeName,
              arguments: {
                "name": userData.name,
                "uid": userData.uid,
              }
            );
          }
        }
      }
      if (!isFound && context.mounted) {
        showSnackbar(
          context,
          "This number doesn't exists on the app",
        );
      }
    } on FirebaseException {
      rethrow;
    } catch (e) {
      if (context.mounted) {
        showSnackbar(
          context,
          e.toString(),
        );
      }
    }
  }
}
