import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/features/select_contacts/repository/select_contact_repository.dart';

final selectContactFutureProvider = FutureProvider((ref) {
  final selectContacts = ref.read(selectContactRepositoryProvider);
  return selectContacts.getContacts();
});

final selectContactControllerProvider = Provider((ref) {
  return SelectContactController(
      selectContactRepository: ref.read(selectContactRepositoryProvider));
});

class SelectContactController {
  final SelectContactRepository selectContactRepository;

  SelectContactController({required this.selectContactRepository});

  void selectContact(Contact selectedContact, BuildContext context) async {
    await selectContactRepository.selectContact(selectedContact, context);
  }
}
