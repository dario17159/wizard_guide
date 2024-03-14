import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wizard_guide/src/core/constants/icon_routes.dart';
import 'package:wizard_guide/src/core/enums/enums.dart';
import 'package:wizard_guide/src/core/extensions/extensions.dart';
import 'package:wizard_guide/src/presenter/pages/profile/profile_controller.dart';

class ProfilePage extends GetWidget<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de usuario'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 24,
            ),
            Hero(
              tag: controller.userData.id,
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage(
                  controller.userData.gender.type == GenderEnum.MALE
                      ? IconRoutes.manPNG
                      : IconRoutes.womanPNG,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ListTile(
              leading: Icon(
                Icons.email_rounded,
                color: context.appColors.secondary,
              ),
              title: Text(
                controller.userData.email,
                style: TextStyle(color: context.appColors.textColorSecondary),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.phone_rounded,
                color: context.appColors.secondary,
              ),
              title: Text(
                controller.userData.phone,
                style: TextStyle(color: context.appColors.textColorSecondary),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person_rounded,
                color: context.appColors.secondary,
              ),
              title: Text(
                controller.userData.gender.value,
                style: TextStyle(color: context.appColors.textColorSecondary),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.assignment_ind_rounded,
                color: context.appColors.secondary,
              ),
              title: Text(
                controller.userData.dateOfBirth.parseToAge.toString(),
                style: TextStyle(color: context.appColors.textColorSecondary),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text('Aceptar'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
