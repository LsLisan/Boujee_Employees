import 'package:get/get.dart';

import '../../features/authentication/controller/login_controller.dart';
import '../../features/splash/controller/splash_controller.dart';

class AppBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(),fenix: true);
    Get.lazyPut(() => LoginController(),fenix: true);


  }

}