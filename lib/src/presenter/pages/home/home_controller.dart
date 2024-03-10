import 'package:get/get.dart';
import 'package:wizard_guide/src/data/repositories/api_repository_impl.dart';
import 'package:wizard_guide/src/domain/repositories/api_repository.dart';
import 'package:wizard_guide/src/presenter/pages/login/login.dart';

class HomeController extends GetxController {
  final IApiRepository _apiRepository = Get.find<ApiRepositoryImpl>();

  void onClickLogout() async {
    await _apiRepository.logout();

    Get.offAll(
      () => const LoginPage(),
      binding: LoginBinding(),
    );
  }
}
