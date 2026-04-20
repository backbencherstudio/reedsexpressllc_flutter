// lib/app/data/models/conversation_model.dart

class ConversationModel {
  final String id;
  final String name;
  final String? role;
  final bool isAdmin;
  final String avatarPath;
  final String lastMessage;
  final String time;
  final int unreadCount;

  const ConversationModel({
    required this.id,
    required this.name,
    this.role,
    this.isAdmin = false,
    required this.avatarPath,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
  });
}