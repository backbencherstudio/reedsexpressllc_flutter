import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reedsexpressllc_flutter/app/data/models/conversation_model.dart';
import 'package:reedsexpressllc_flutter/app/routes/app_pages.dart';

class MessageController extends GetxController {
  final searchController = TextEditingController();
  final searchQuery = ''.obs;

  final conversations = <ConversationModel>[
    ConversationModel(
      id: 'conv_1',
      name: 'Springle Burger',
      avatarPath: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVVxhlpR8Ei3A2AHj0tJQnkWUwA0VCMiVkMw&s",
      lastMessage: 'Hi, Mandy...',
      time: '25 min ago',
      unreadCount: 2,
    ),
    ConversationModel(
      id: 'conv_2',
      name: 'Jennifer',
      role: 'Admin',
      isAdmin: true,
      avatarPath: "https://png.pngtree.com/png-vector/20230831/ourmid/pngtree-man-avatar-image-for-profile-png-image_9197908.png",
      lastMessage: 'Really?',
      time: '25 min ago',
    ),
    ConversationModel(
      id: 'conv_3',
      name: 'Robinson',
      avatarPath: "https://img.freepik.com/premium-vector/cute-woman-avatar-profile-vector-illustration_1058532-14592.jpg?w=360",
      lastMessage: 'Transportation Done!',
      time: '25 min ago',
    ),
    ConversationModel(
      id: 'conv_4',
      name: 'Springle Burger',
      avatarPath: "https://png.pngtree.com/png-vector/20241211/ourmid/pngtree-avatar-icon-picture-man-beard-flat-illustration-vector-png-image_14686471.png",
      lastMessage: 'Hi, Mandy...',
      time: '25 min ago',
    ),
    ConversationModel(
      id: 'conv_5',
      name: 'Jennifer',
      avatarPath: "https://thumbs.dreamstime.com/b/profile-avatar-man-glasses-beard-stock-illustration-312869172.jpg",
      lastMessage: 'Really?',
      time: '25 min ago',
    ),
    ConversationModel(
      id: 'conv_6',
      name: 'Robinson',
      avatarPath: "https://png.pngtree.com/png-vector/20230903/ourmid/pngtree-man-avatar-isolated-png-image_9935818.png",
      lastMessage: 'Transportation Done!',
      time: '25 min ago',
    ),
  ].obs;

  List<ConversationModel> get filteredConversations {
    if (searchQuery.value.isEmpty) return conversations;
    return conversations
        .where(
          (c) => c.name.toLowerCase().contains(searchQuery.value.toLowerCase()),
        )
        .toList();
  }

  void onSearch(String value) => searchQuery.value = value;

  void openChat(ConversationModel conversation) {
    Get.toNamed(Routes.CHAT, arguments: conversation);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
