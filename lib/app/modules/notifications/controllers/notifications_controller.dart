import 'package:get/get.dart';

class NotificationModel {
  final String id;
  final String title;
  final String description;
  final String timeText;
  final bool isUnread;
  final String actionText;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.timeText,
    this.isUnread = false,
    this.actionText = '',
  });
}

class NotificationsController extends GetxController {
  bool isInit = false;
  RxBool isLoading = false.obs;
  bool isEndPage = true;
  
  List<NotificationModel> activeNotifications = [];

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  Future<void> getNotifications({bool isRefresh = false}) async {
    if (isRefresh) {
      activeNotifications.clear();
      isEndPage = false;
    }
    
    if (activeNotifications.isEmpty) {
      isInit = true;
      update(['update_notifications']);
    } else {
      isLoading.value = true;
    }

    // Mock API delay
    await Future.delayed(const Duration(seconds: 1));

    if (activeNotifications.isEmpty) {
      activeNotifications = [
        NotificationModel(
          id: '1',
          title: 'New load assignment',
          description: 'You\'ve been assigned to a new Load. ',
          actionText: 'View Details',
          timeText: '2m ago',
          isUnread: true,
        ),
        NotificationModel(
          id: '2',
          title: 'Vehicle information Update',
          description: 'Your vehicle details have been updated',
          timeText: '2m ago',
          isUnread: true,
        ),
        NotificationModel(
          id: '3',
          title: 'Document Verification',
          description: 'Your carrier info and documents have been approved',
          timeText: '10m ago',
          isUnread: true,
        ),
      ];
    }
    
    isInit = false;
    isLoading.value = false;
    update(['update_notifications']);
  }
}
