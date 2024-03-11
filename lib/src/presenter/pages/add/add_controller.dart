import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wizard_guide/src/core/enums/enums.dart';
import 'package:wizard_guide/src/core/services/dialog_service.dart';
import 'package:wizard_guide/src/core/services/snackbar_service.dart';
import 'package:wizard_guide/src/data/repositories/api_repository_impl.dart';
import 'package:wizard_guide/src/domain/entities/task_data.dart';
import 'package:wizard_guide/src/domain/entities/task_status.dart';
import 'package:wizard_guide/src/domain/repositories/api_repository.dart';

class AddController extends GetxController {
  final IApiRepository _apiRepository = Get.find<ApiRepositoryImpl>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  final Rx<File?> image = Rx<File?>(null);
  final FocusNode titleFocus = FocusNode();

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    titleFocus.dispose();
    super.onClose();
  }

  Future<void> onClickAdd() async {
    try {
      if (titleController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty) {
        DialogService.showLoading(message: 'Agregando tarea...');
        final taskData = TaskData(
            title: titleController.text.trim(),
            description: descriptionController.text.trim(),
            imageUrl: '',
            status: TaskStatus(value: 'Pendiente', type: TaskStatusENUM.PENDING),
            imageFile: image.value);
        await _apiRepository.addTask(taskData);
        _resetFieldValues();
        DialogService.hideLoading();
        SnackbarService.showSuccess(
          title: 'Enhorabuena',
          message: 'La tarea se a almacenado correctamente',
          position: SnackPosition.TOP,
        );
      } else {
        SnackbarService.showInformative(
          title: 'Atención',
          message: 'Revisa que todos los campos requeridos esten completos',
        );
      }
    } catch (e) {
      DialogService.hideLoading();
      SnackbarService.showError(
        title: 'Atención',
        message:
            'Ocurrió un error al crear la tarea, volve a intentarlo nuevamente.',
        position: SnackPosition.TOP,
      );
    }
  }

  void onClickAddImage(BuildContext context) {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'De donde desea cargar la imagen?',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () {
                    Get.back();
                    _onPickImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.wallpaper),
                  label: const Text('Galeria'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () {
                    Get.back();
                    _onPickImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera_alt_rounded),
                  label: const Text('Camara'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onPickImage(ImageSource source) async {
    final XFile? pickerResult = await _imagePicker.pickImage(source: source);
    if (pickerResult != null) {
      image.value = File(pickerResult.path);
    }
  }

  void onClickDeleteImage() => image.value = null;

  void _resetFieldValues() {
    titleController.clear();
    descriptionController.clear();
    image.value = null;
    titleFocus.requestFocus();
  }
}
