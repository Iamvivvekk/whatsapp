

import 'package:whatsapp/core/common/enums/message_enums.dart';

class Message {
  final String senderUserId;
  final String receiverId;
  final MessageEnum type;
  final String text;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;
  final String repliedMessage;
  final String repliedTo;
  final MessageEnum repliedMessageType;
  
  Message({
    required this.senderUserId,
    required this.receiverId,
    required this.type,
    required this.text,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
    required this.repliedMessage,
    required this.repliedTo,
    required this.repliedMessageType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderUserId': senderUserId,
      'receiverId': receiverId,
      'type': type.type,
      'text': text,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'messageId': messageId,
      'isSeen': isSeen,
      'repliedMessage': repliedMessage,
      'repliedTo': repliedTo,
      'repliedMessageType': repliedMessageType.type,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderUserId: map['senderUserId'] as String,
      receiverId: map['receiverId'] as String,
      type: (map['type'] as String).toEnum(),
      text: map['text'] as String,
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
      messageId: map['messageId'] as String,
      isSeen: map['isSeen'] as bool,
      repliedMessage: map['repliedMessage'] as String,
      repliedTo: map['repliedTo'] as String,
      repliedMessageType: (map['repliedMessageType'] as String).toEnum(),
    );
  }

  Message copyWith({
    String? senderUserId,
    String? receiverId,
    MessageEnum? type,
    String? text,
    DateTime? timeSent,
    String? messageId,
    bool? isSeen,
    String? repliedMessage,
    String? repliedTo,
    MessageEnum? repliedMessageType,
  }) {
    return Message(
      senderUserId: senderUserId ?? this.senderUserId,
      receiverId: receiverId ?? this.receiverId,
      type: type ?? this.type,
      text: text ?? this.text,
      timeSent: timeSent ?? this.timeSent,
      messageId: messageId ?? this.messageId,
      isSeen: isSeen ?? this.isSeen,
      repliedMessage: repliedMessage ?? this.repliedMessage,
      repliedTo: repliedTo ?? this.repliedTo,
      repliedMessageType: repliedMessageType ?? this.repliedMessageType,
    );
  }

  @override
  String toString() {
    return 'Message(senderUserId: $senderUserId, receiverId: $receiverId, type: $type, text: $text, timeSent: $timeSent, messageId: $messageId, isSeen: $isSeen, repliedMessage: $repliedMessage, repliedTo: $repliedTo, repliedMessageType: $repliedMessageType)';
  }
}
