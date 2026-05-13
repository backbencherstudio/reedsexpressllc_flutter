import 'package:get/get.dart';

import '../modules/active_load_list/bindings/active_load_list_binding.dart';
import '../modules/active_load_list/views/active_load_list_view.dart';
import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/documents/bindings/documents_binding.dart';
import '../modules/documents/views/documents_view.dart';
import '../modules/earnings/bindings/earnings_binding.dart';
import '../modules/earnings/views/earnings_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/license_and_certifications/bindings/license_and_certifications_binding.dart';
import '../modules/license_and_certifications/views/license_and_certifications_view.dart';
import '../modules/load/bindings/load_binding.dart';
import '../modules/load/views/load_view.dart';
import '../modules/load_details/bindings/load_details_binding.dart';
import '../modules/load_details/views/load_details_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main_page/bindings/main_page_binding.dart';
import '../modules/main_page/views/main_page_view.dart';
import '../modules/message/bindings/message_binding.dart';
import '../modules/message/chat/bindings/chat_binding.dart';
import '../modules/message/chat/views/chat_view.dart';
import '../modules/message/views/message_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/onboard/bindings/onboard_binding.dart';
import '../modules/onboard/views/onboard_view.dart';
import '../modules/personal_info/bindings/personal_info_binding.dart';
import '../modules/personal_info/views/personal_info_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/settings_notification/bindings/settings_notification_binding.dart';
import '../modules/settings_notification/views/settings_notification_view.dart';
import '../modules/show_map/bindings/show_map_binding.dart';
import '../modules/show_map/views/show_map_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/upload_documents/bindings/upload_documents_binding.dart';
import '../modules/upload_documents/views/upload_documents_view.dart';
import '../modules/vehicle/bindings/vehicle_binding.dart';
import '../modules/vehicle/views/vehicle_view.dart';
import '../modules/verify_otp/bindings/verify_otp_binding.dart';
import '../modules/verify_otp/views/verify_otp_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_PAGE,
      page: () => const MainPageView(),
      binding: MainPageBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_OTP,
      page: () => const VerifyOtpView(),
      binding: VerifyOtpBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.LOAD,
      page: () => const LoadView(),
      binding: LoadBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGE,
      page: () => const MessageView(),
      binding: MessageBinding(),
      children: [
        GetPage(
          name: _Paths.CHAT,
          page: () => const ChatView(),
          binding: ChatBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.DOCUMENTS,
      page: () => const DocumentsView(),
      binding: DocumentsBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARD,
      page: () => const OnboardView(),
      binding: OnboardBinding(),
    ),
    GetPage(
      name: _Paths.UPLOAD_DOCUMENTS,
      page: () => const UploadDocumentsView(),
      binding: UploadDocumentsBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVE_LOAD_LIST,
      page: () => const ActiveLoadListView(),
      binding: ActiveLoadListBinding(),
    ),
    GetPage(
      name: _Paths.LOAD_DETAILS,
      page: () => const LoadDetailsView(),
      binding: LoadDetailsBinding(),
    ),
    GetPage(
      name: _Paths.EARNINGS,
      page: () => const EarningsView(),
      binding: EarningsBinding(),
    ),
    GetPage(
      name: _Paths.PERSONAL_INFO,
      page: () => const PersonalInfoView(),
      binding: PersonalInfoBinding(),
    ),
    GetPage(
      name: _Paths.LICENSE_AND_CERTIFICATIONS,
      page: () => const LicenseAndCertificationsView(),
      binding: LicenseAndCertificationsBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.VEHICLE,
      page: () => const VehicleView(),
      binding: VehicleBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS_NOTIFICATION,
      page: () => const SettingsNotificationView(),
      binding: SettingsNotificationBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_MAP,
      page: () => const ShowMapView(),
      binding: ShowMapBinding(),
    ),
  ];
}
