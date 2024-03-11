import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wizard_guide/src/core/constants/constants.dart';
import 'package:wizard_guide/src/domain/entities/task_status.dart';
import 'package:wizard_guide/src/presenter/pages/detail/detail_controller.dart';

class DetailPage extends GetWidget<DetailController> {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalle de tarea',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const _ImageContainer(),
            const SizedBox(height: 16),
            Text(
              controller.task.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              controller.task.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<TaskStatus?>(
              value: controller.statusList.first,
              items: controller.statusList
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(item.value),
                      ))
                  .toList(),
              onChanged: (value) {},
            ),
            const SizedBox(height: 24),
            Obx(
              () => FadeIn(
                animate: controller.canUpdate.value,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.onClickConfirmUpdate(),
                    child: const Text('Actualizar'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageContainer extends GetWidget<DetailController> {
  const _ImageContainer();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AspectRatio(
      aspectRatio: 1.1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: controller.task.imageUrl.isNotEmpty
            ? Image.network(
                controller.task.imageUrl,
                width: size.width,
                height: size.width,
                fit: BoxFit.cover,
              )
            : Image.asset(
                IconRoutes.placeHolderWEBP,
                width: size.width,
                height: size.width,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
