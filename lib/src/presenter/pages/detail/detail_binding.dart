import 'package:get/get.dart';
import 'package:wizard_guide/src/presenter/pages/detail/detail_controller.dart';

class DetailBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<DetailController>(() => DetailController());
  }
}