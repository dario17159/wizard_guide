import 'package:get/get.dart';
import 'package:wizard_guide/src/presenter/pages/login/login_controller.dart';

class LoginBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<LoginController>(() => LoginController());
  }
}