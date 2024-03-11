import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wizard_guide/src/core/constants/icon_routes.dart';
import 'package:wizard_guide/src/presenter/pages/add/add_controller.dart';

class AddPage extends GetWidget<AddController> {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva tarea'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Para poder crear una nueva tarea, debes completar los siguientes campos',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Imagen',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Spacer(),
                Obx(
                  () => controller.image.value !=null? IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => controller.onClickDeleteImage(),
                    icon: const Icon(Icons.delete_rounded),
                  ) : const SizedBox(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Obx(
              () => ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: controller.image.value == null
                    ? Image.asset(
                        IconRoutes.placeHolderWEBP,
                        width: size.width,
                        height: size.width,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        controller.image.value!,
                        width: size.width,
                        height: size.width,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Nota: La imagen debe cumplir con las dimensiones 1:1',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Agregar imagen'),
                onPressed: () => controller.onClickAddImage(context),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.titleController,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Titulo*'),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.descriptionController,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Descripción*'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Confirmar'),
                onPressed: () => controller.onClickAdd(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
