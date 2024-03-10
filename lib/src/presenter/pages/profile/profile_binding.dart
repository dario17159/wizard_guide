import 'package:get/get.dart';
import 'package:wizard_guide/src/presenter/pages/profile/profile_controller.dart';

class ProfileBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<ProfileController>(() => ProfileController());
  }
}