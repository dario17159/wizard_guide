import 'package:get/get.dart';
import 'package:wizard_guide/src/core/constants/constants.dart';
import 'package:wizard_guide/src/core/services/services.dart';
import 'package:wizard_guide/src/data/repositories/api_repository_impl.dart';
import 'package:wizard_guide/src/domain/entities/entities.dart';
import 'package:wizard_guide/src/domain/repositories/api_repository.dart';
import 'package:wizard_guide/src/presenter/pages/login/login.dart';
import 'package:wizard_guide/src/presenter/pages/profile/profile.dart';

class HomeController extends GetxController {
  final IApiRepository _apiRepository = Get.find<ApiRepositoryImpl>();
  Rx<UserData?> userData = Rx<UserData?>(null);

  @override
  void onInit() {
    _loadUserData();
    super.onInit();
  }

  Future<void> _loadUserData() async {
    final jsonData = await StorageService.getObject(StorageKeys.USER_DATA);
    if (jsonData != null) {
      userData.value = UserData.fromRawJson(jsonData);
    }
  }

  void onClickLogout() async {
    await _apiRepository.logout();

    Get.offAll(
      () => const LoginPage(),
      binding: LoginBinding(),
    );
  }

  void onClickProfile() {

    Get.to(
      () => const ProfilePage(),
      binding: ProfileBinding(),
      arguments: userData.value!,
    );
  }
}
