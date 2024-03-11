import 'package:flutter/material.dart';
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
  RxInt currentPageIndex = 0.obs;
  final PageController pageController = PageController(initialPage: 0);

  @override
  void onInit() {
    _loadUserData();
    pageController.addListener(_scrollListener);
    super.onInit();
  }

  void _scrollListener() {
    if (pageController.page! > .5 && pageController.page! < 1.5) {
      currentPageIndex.value = 1;
    } else if (pageController.page! < .5) {
      currentPageIndex.value = 0;
    } else if (pageController.page! > 1.5) {
      currentPageIndex.value = 2;
    }
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

  void onClickBottomItem(int page) {
    currentPageIndex.value = page;
    pageController.animateToPage(page, duration:const Duration(milliseconds: 300),curve: Curves.easeIn,);
  }

  @override
  void onClose() {
    pageController.removeListener(_scrollListener);
    pageController.dispose();
    super.onClose();
  }
}
