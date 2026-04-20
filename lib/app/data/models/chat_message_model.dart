// lib/app/data/models/chat_message_model.dart

enum MessageType { text, image, pdf, document }

enum MessageSender { me, other }

class ChatMessageModel {
  final String id;
  final String text;
  final MessageType type;
  final MessageSender sender;
  final String time;
  final String? filePath;
  final String? fileName;
  final String? docType;
  final bool isTyping;

  const ChatMessageModel({
    required this.id,
    required this.text,
    required this.type,
    required this.sender,
    required this.time,
    this.filePath,
    this.fileName,
    this.docType,
    this.isTyping = false,
  });

  ChatMessageModel copyWith({
    String? id,
    String? text,
    MessageType? type,
    MessageSender? sender,
    String? time,
    String? filePath,
    String? fileName,
    String? docType,
    bool? isTyping,
  }) {
    return ChatMessageModel(
      id: id ?? this.id,
      text: text ?? this.text,
      type: type ?? this.type,
      sender: sender ?? this.sender,
      time: time ?? this.time,
      filePath: filePath ?? this.filePath,
      fileName: fileName ?? this.fileName,
      docType: docType ?? this.docType,
      isTyping: isTyping ?? this.isTyping,
    );
  }
}