class ChatContactsModel {
  final String name;
  final String profilePic;
  final String contactId;
  final String lastMessage;
  final DateTime timeSent;
  ChatContactsModel({
    required this.name,
    required this.profilePic,
    required this.contactId,
    required this.lastMessage,
    required this.timeSent,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profilePic': profilePic,
      'contactId': contactId,
      'lastMessage': lastMessage,
      'timeSent': timeSent.millisecondsSinceEpoch,
    };
  }

  factory ChatContactsModel.fromMap(Map<String, dynamic> map) {
    return ChatContactsModel(
      name: map['name'] ?? "",
      profilePic: map['profilePic'] ?? "",
      contactId: map['contactId'] ?? "",
      lastMessage: map['lastMessage'] ?? "",
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
    );
  }
}
