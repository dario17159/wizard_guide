import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wizard_guide/src/presenter/pages/detail/detail.dart';
import 'package:wizard_guide/src/presenter/pages/home/home_controller.dart';
import 'package:wizard_guide/src/presenter/widgets/widgets.dart';

class PendingTaskPage extends GetWidget<HomeController> {
  const PendingTaskPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        controller: controller.scrollController,
        itemCount: controller.taskPendingList.length,
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        itemBuilder: (context, index) {
          final task = controller.taskPendingList[index];
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
