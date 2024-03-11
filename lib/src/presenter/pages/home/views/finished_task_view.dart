import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wizard_guide/src/presenter/pages/detail/detail.dart';
import 'package:wizard_guide/src/presenter/pages/home/home_controller.dart';
import 'package:wizard_guide/src/presenter/widgets/widgets.dart';

class FinishedTaskPage extends GetWidget<HomeController> {
  const FinishedTaskPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: controller.taskFinishedList.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final task = controller.taskFinishedList[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: TaskCard(
              onPressed: () => Get.to(
                () => const DetailPage(),
                binding: DetailBinding(),
                arguments: task,
              ),
              task: task,
            ),
          );
        },
      ),
    );
  }
}
