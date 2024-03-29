import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:wizard_guide/src/core/constants/constants.dart';
import 'package:wizard_guide/src/core/enums/enums.dart';
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
  final ScrollController scrollController = ScrollController();
  RxBool fabVisible = true.obs;

  RxList<TaskData> taskPendingList = <TaskData>[].obs;
  RxList<TaskData> taskInProgressList = <TaskData>[].obs;
  RxList<TaskData> taskFinishedList = <TaskData>[].obs;
  Rx<ThemeMode> currentTheme = ThemeMode.system.obs;

  @override
  void onInit() {
    _loadUserData();
    taskPendingList.bindStream(_apiRepository.getTask(TaskStatusENUM.PENDING));
    taskInProgressList
        .bindStream(_apiRepository.getTask(TaskStatusENUM.IN_PROGRESS));
    taskFinishedList
        .bindStream(_apiRepository.getTask(TaskStatusENUM.FINISHED));

    pageController.addListener(_pageControllerListener);
    scrollController.addListener(_scrollControllerListener);
    super.onInit();
  }

  void _pageControllerListener() {
    if (pageController.page! > .5 && pageController.page! < 1.5) {
      currentPageIndex.value = 1;
    } else if (pageController.page! < .5) {
      currentPageIndex.value = 0;
    } else if (pageController.page! > 1.5) {
      currentPageIndex.value = 2;
    }
  }

  void _scrollControllerListener() {
    log(scrollController.position.userScrollDirection.name);
    if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse &&
        fabVisible.value) {
      fabVisible.value = false;
    }
    if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward &&
        !fabVisible.value) {
      fabVisible.value = true;
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
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  // function to switch between themes
  void switchTheme() {
    currentTheme.value = currentTheme.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    Get.changeThemeMode(currentTheme.value);
  }

  @override
  void onClose() {
    taskPendingList.close();
    taskInProgressList.close();
    taskFinishedList.close();

    pageController.removeListener(_pageControllerListener);
    scrollController.removeListener(_scrollControllerListener);
    pageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
