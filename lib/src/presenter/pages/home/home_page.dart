import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wizard_guide/src/core/constants/icon_routes.dart';
import 'package:wizard_guide/src/core/enums/enums.dart';
import 'package:wizard_guide/src/core/extensions/extensions.dart';
import 'package:wizard_guide/src/presenter/pages/add/add.dart';
import 'package:wizard_guide/src/presenter/pages/home/home_controller.dart';
import 'package:wizard_guide/src/presenter/pages/home/views/views.dart';

class HomePage extends GetWidget<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        drawer: const _DrawerWidget(),
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: const Text('Wizard Guide'),
        ),
        body: PageView(
          controller: controller.pageController,
          children: const [
            PendingTaskPage(),
            InProgressTaskPage(),
            FinishedTaskPage(),
          ],
        ),
        floatingActionButton: (controller.currentPageIndex.value == 0 &&
                controller.fabVisible.value)
            ? FloatingActionButton(
                onPressed: () =>
                    Get.to(() => const AddPage(), binding: AddBinding()),
                backgroundColor: context.appColors.primary,
                foregroundColor: Colors.white,
                child: const Icon(Icons.post_add),
              )
            : null,
        bottomNavigationBar: const _BottomBarWidget(),
      ),
    );
  }
}

class _BottomBarWidget extends GetWidget<HomeController> {
  const _BottomBarWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Pendientes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rule_rounded),
            label: 'En progreso',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_rtl_rounded),
            label: 'Terminadas',
          ),
        ],
        currentIndex: controller.currentPageIndex.value,
        selectedItemColor: const Color(0xffED5828),
        onTap: (value) => controller.onClickBottomItem(value),
      ),
    );
  }
}

class _DrawerWidget extends GetWidget<HomeController> {
  const _DrawerWidget();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: Obx(
                    () => Column(
                      children: [
                        Hero(
                          tag: controller.userData.value?.id ?? '',
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(
                              controller.userData.value?.gender.type ==
                                      GenderEnum.MALE
                                  ? IconRoutes.manPNG
                                  : IconRoutes.womanPNG,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          controller.userData.value?.email ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: context.appColors.textColorSecondary),
                        ),
                        Text(
                          controller.userData.value?.phone ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: context.appColors.textColorSecondary),
                        )
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: context.appColors.secondary,
                  ),
                  title: Text(
                    'Perfil',
                    style:
                        TextStyle(color: context.appColors.textColorSecondary),
                  ),
                  onTap: () => controller.onClickProfile(),
                ),
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app_rounded,
                    color: context.appColors.secondary,
                  ),
                  title: Text(
                    'Cerrar sesión',
                    style:
                        TextStyle(color: context.appColors.textColorSecondary),
                  ),
                  onTap: () => controller.onClickLogout(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
