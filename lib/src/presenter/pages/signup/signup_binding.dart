import 'package:get/get.dart';
import 'package:wizard_guide/src/presenter/pages/signup/signup_controller.dart';

class SignUpBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<SignUpController>(() => SignUpController());
  }
}