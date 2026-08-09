import 'package:get/get.dart';

import '../../features/authentication/controller/login_controller.dart';
import '../../features/employee_nav/employee_nav_controller.dart';
import '../../features/employee_profile/controller/edit_profile_controller.dart';
import '../../features/employee_profile/controller/employee_profile_controller.dart';
import '../../features/employee_profile/presentation/screen/employee_profile_screen.dart';
import '../../features/messaging/controller/messaging_controller.dart';
import '../../features/splash/controller/splash_controller.dart';

class AppBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(),fenix: true);
    Get.lazyPut(() => LoginController(),fenix: true);
    Get.lazyPut(() => EmployeeNavController(),fenix: true);
    Get.lazyPut(() => MessagingController(),fenix: true);
    Get.lazyPut(() => EmployeeProfileController(),fenix: true);
    Get.lazyPut(() => EditProfileController(),fenix: true);

  }

}