import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../features/authentication/presentation/screen/forget_new_password_screen.dart';
import '../features/authentication/presentation/screen/forget_password_screen.dart';
import '../features/authentication/presentation/screen/forget_password_verify_screen.dart' hide ForgetPasswordScreen;
import '../features/authentication/presentation/screen/login_screen.dart';
import '../features/employee_nav/employee_nav_bar.dart';
import '../features/employee_profile/presentation/screen/certificate_screen.dart';
import '../features/employee_profile/presentation/screen/edit_profile_screen.dart';
import '../features/employee_profile/presentation/screen/privacy_policy_screen.dart';
import '../features/messaging/presentation/screen/chat_screen.dart';
import '../features/splash/presentation/screen/splash_screen.dart';

class AppRoutes {

  static const String init = '/';
  static const String employeeNavBar = '/employeeNavBar';

  static const String login = '/login';
  static const String forgetPassword = '/forgetPassword';
  static const String forgetPasswordVerification = '/forgetPasswordVerification';
  static const String resetPassword = '/resetPassword';

  static const String chat = '/chat';

  static const String editProfile = '/editProfile';
  static const String privacyPolicy = '/privacyPolicy';
  static const String certificate = '/certificate';



  static final List<GetPage> routes = [
    GetPage(
      name: init,
      page: () => SplashScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: forgetPassword, page: () => ForgetPasswordScreen()),
    GetPage(
      name: forgetPasswordVerification,
      page: () => ForgetPasswordVerifyScreen(),
    ),
    GetPage(name: resetPassword, page: () => ForgetNewPasswordScreen()),


    GetPage(
      name: employeeNavBar,
      page: () => EmployeeNavBar(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: chat,
      page: () => ChatScreen(),
      transition: Transition.cupertino,
    ),

    GetPage(
      name: editProfile,
      page: () => EditProfileScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: privacyPolicy,
      page: () => PrivacyPolicyScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: certificate,
      page: () => CertificateScreen(),
      transition: Transition.cupertino,
    ),



  ];


}