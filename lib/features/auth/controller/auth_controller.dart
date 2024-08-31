import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/features/auth/repository/auth_repository.dart';
import 'package:whatsapp/models/user_model.dart';

final authControllerProvider = Provider<AuthController>((ref) {
  return AuthController(
    authRepository: ref.read(authRepositoryProvider),
    ref: ref,
  );
});

final userDataAuthProvider = FutureProvider((ref) async {
 return ref.watch(authControllerProvider).getUserData();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController({required this.authRepository, required this.ref});

  Future<UserModel?> getUserData() async {
    return await authRepository.getUserData();
  }

  void signInWithPhoneNumber(BuildContext context, String phoneNumber) async {
    authRepository.signInWithPhone(context, phoneNumber);
  }

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
  }) {
    authRepository.verifyOtp(
      context: context,
      verificationId: verificationId,
      userOtp: userOtp,
    );
  }

  Future<void> storeUserDataToFirebase({
    required BuildContext context,
    required String name,
    required File? profilePic,
  }) async {
    await authRepository.storeUserDataToFirebase(
      context: context,
      name: name,
      profilePic: profilePic,
      ref: ref,
    );
  }
}
