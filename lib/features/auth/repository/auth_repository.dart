import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/core/repositories/common_firebase_storage_repositories.dart';
import 'package:whatsapp/core/utils/show_snakebar.dart';
import 'package:whatsapp/features/auth/screen/otp_screen.dart';
import 'package:whatsapp/features/auth/screen/user_information_screen.dart';
import 'package:whatsapp/models/user_model.dart';
import 'package:whatsapp/screens/mobile_layout.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) {
    return AuthRepository(
      auth: FirebaseAuth.instance,
      fireStore: FirebaseFirestore.instance,
    );
  },
);

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _fireStore;
  AuthRepository(
      {required FirebaseAuth auth, required FirebaseFirestore fireStore})
      : _auth = auth,
        _fireStore = fireStore;

  Future<UserModel?> getUserData() async {
    final userData =
        await _fireStore.collection("users").doc(_auth.currentUser?.uid).get();
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.pushNamed(
            context,
            OtpScreen.routeName,
            arguments: verificationId,
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        verificationFailed: (FirebaseAuthException exception) {
          throw exception;
        },
      );
    } on FirebaseException {
      rethrow;
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOtp,
      );
      await _auth.signInWithCredential(credential);
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          UserInformationScreen.routeName,
          (route) => false,
        );
      }
    } on FirebaseException catch (e) {
      if (context.mounted) {
        showSnackbar(context, e.toString());
      }
    }
  }

  Future<void> storeUserDataToFirebase({
    required BuildContext context,
    required String name,
    required File? profilePic,
    required ProviderRef ref,
  }) async {
    String photoUrl =
        "https://tse2.mm.bing.net/th?id=OIP.tgmmCh4SA36j0dMT0ay9_AAAAA&pid=Api&P=0&h=220";
    try {
      String uid = _auth.currentUser!.uid;

      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoriesProvider)
            .storeFileToFirebaseStorage(
              "profilePic/$uid",
              profilePic,
            );

      }
      final user = UserModel(
        name: name,
        uid: uid,
        profilePic: photoUrl,
        isOnline: true,
        phoneNumber: _auth.currentUser!.phoneNumber.toString(),
        groupId: [],
      );

      await _fireStore.collection("users").doc(uid).set(user.toMap());
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          MobileScreenLayout.routeName,
          (route) => false,
        );
      }
    } on FirebaseException catch (e) {
      if (context.mounted) {
        showSnackbar(context, e.toString());
      }
    }
  }
}
