// lib/app/modules/chat/controllers/chat_controller.dart

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as p;
import 'package:reedsexpressllc_flutter/app/core/utils/logger.dart';
import 'package:reedsexpressllc_flutter/app/data/models/chat_message_model.dart';
import 'package:reedsexpressllc_flutter/app/data/models/conversation_model.dart';

class ChatController extends GetxController {
  late ConversationModel conversation;
  final messageController = TextEditingController();
  final scrollController = ScrollController();
  final isTyping = false.obs;
  final isSending = false.obs;

  // Pending attachment before sending
  final pendingFilePath = RxnString();
  final pendingFileName = RxnString();
  final pendingDocType = RxnString();
  final pendingMessageType = Rx<MessageType>(MessageType.text);

  final messages = <ChatMessageModel>[
    ChatMessageModel(
      id: '1',
      text: 'Hi, Mandy',
      type: MessageType.text,
      sender: MessageSender.me,
      time: '09:41 AM',
    ),
    ChatMessageModel(
      id: '2',
      text: "I've tried the app",
      type: MessageType.text,
      sender: MessageSender.me,
      time: '09:41 AM',
    ),
    ChatMessageModel(
      id: '3',
      text: 'Really?',
      type: MessageType.text,
      sender: MessageSender.other,
      time: '09:41 AM',
    ),
    ChatMessageModel(
      id: '4',
      text: "Yeah, It's really good!",
      type: MessageType.text,
      sender: MessageSender.me,
      time: '09:41 AM',
    ),
    ChatMessageModel(
      id: 'typing',
      text: 'Typing...',
      type: MessageType.text,
      sender: MessageSender.other,
      time: '',
      isTyping: true,
    ),
  ].obs;

  // All document types for picker
  final docTypes = <String>[
    'General Document',
    'Driver Card',
    'Medical License',
    'Medical Card',
    'Vehicle Registration',
    'Permit',
    'Traffic Ticket',
    'Receipt',
    'POD - Proof of Delivery',
    'BOL - Bill of Lading',
    'Rate Confirmation',
    'Scale Ticket',
    'Lumper Fee',
    'Inspection Report',
  ];

  @override
  void onInit() {
    super.onInit();
    conversation = Get.arguments as ConversationModel;
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ── Send text message ───────────────────────────────────

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty && pendingFilePath.value == null) return;

    final now = _currentTime();

    if (pendingFilePath.value != null) {
      // Send file message
      messages.insert(
        messages.length - 1, // insert before typing indicator
        ChatMessageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: pendingFileName.value ?? '',
          type: pendingMessageType.value,
          sender: MessageSender.me,
          time: now,
          filePath: pendingFilePath.value,
          fileName: pendingFileName.value,
          docType: pendingDocType.value,
        ),
      );
      _clearPending();
    }

    if (text.isNotEmpty) {
      messages.insert(
        messages.length - 1,
        ChatMessageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: text,
          type: MessageType.text,
          sender: MessageSender.me,
          time: now,
        ),
      );
      messageController.clear();
    }

    scrollToBottom();
  }

  void _clearPending() {
    pendingFilePath.value = null;
    pendingFileName.value = null;
    pendingDocType.value = null;
    pendingMessageType.value = MessageType.text;
  }

  void cancelPending() => _clearPending();

  // ── Attachment pickers ──────────────────────────────────

  Future<void> pickFromCamera() async {
    try {
      final picked =
      await ImagePicker().pickImage(source: ImageSource.camera);
      if (picked != null) {
        pendingFilePath.value = picked.path;
        pendingFileName.value = p.basename(picked.path);
        pendingMessageType.value = MessageType.image;
      }
    } catch (e) {
      Log.e(e);
    }
  }

  Future<void> pickFromGallery() async {
    try {
      final picked =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked != null) {
        pendingFilePath.value = picked.path;
        pendingFileName.value = p.basename(picked.path);
        pendingMessageType.value = MessageType.image;
      }
    } catch (e) {
      Log.e(e);
    }
  }

  Future<void> pickDocument(String docType) async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );
      if (result != null && result.files.single.path != null) {
        final path = result.files.single.path!;
        pendingFilePath.value = path;
        pendingFileName.value = p.basename(path);
        pendingDocType.value = docType;
        pendingMessageType.value = _isPdf(path)
            ? MessageType.pdf
            : MessageType.document;
      }
    } catch (e) {
      Log.e(e);
    }
  }

  bool _isPdf(String path) =>
      p.extension(path).toLowerCase() == '.pdf';

  bool isImage(String path) {
    final ext = p.extension(path).toLowerCase();
    return ext == '.jpg' || ext == '.jpeg' || ext == '.png';
  }

  Future<void> openFile(String filePath) async {
    await OpenFilex.open(filePath);
  }

  String _currentTime() {
    final now = DateTime.now();
    final hour = now.hour.toString().padLeft(2, '0');
    final min = now.minute.toString().padLeft(2, '0');
    return '$hour:$min';
  }
}