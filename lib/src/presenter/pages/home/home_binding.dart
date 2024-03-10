import 'package:get/get.dart';
import 'package:wizard_guide/src/presenter/pages/home/home_controller.dart';

class HomeBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<HomeController>(() => HomeController());
  }
}