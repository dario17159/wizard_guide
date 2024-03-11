import 'package:get/get.dart';
import 'package:wizard_guide/src/presenter/pages/add/add_controller.dart';

class AddBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<AddController>(() => AddController());
  }
}