import 'package:get/get.dart';
import 'package:wizard_guide/src/domain/entities/entities.dart';

class ProfileController extends GetxController {
  late UserData userData;

  @override
  void onInit() {
    userData = Get.arguments as UserData;
    super.onInit();
  }


}
