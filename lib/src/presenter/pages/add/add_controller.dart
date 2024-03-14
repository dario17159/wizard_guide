import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wizard_guide/src/core/enums/enums.dart';
import 'package:wizard_guide/src/core/extensions/extensions.dart';
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
            status:
                TaskStatus(value: 'Pendiente', type: TaskStatusENUM.PENDING),
            imageFile: image.value);
        await _apiRepository.addTask(taskData);
        _resetFieldValues();
        DialogService.hideLoading();
        SnackbarService.showSuccess(
          title: 'Listo! 🍻',
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
        decoration:  BoxDecoration(
          color: context.appColors.appBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
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
                    _onPickImage(ImageSource.gallery, context);
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
                    _onPickImage(ImageSource.camera, context);
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

  Future<void> _onPickImage(ImageSource source, BuildContext context) async {
    try {
      final XFile? pickerResult = await _imagePicker.pickImage(source: source);
      if (pickerResult != null) {
        // ignore: use_build_context_synchronously
        image.value = await _cropImage(File(pickerResult.path), context);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<File?> _cropImage(File imageFile, BuildContext context) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Recortar Imagen',
          toolbarColor: context.appColors.primary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Recortar Imagen',
          aspectRatioLockEnabled: true,
          aspectRatioLockDimensionSwapEnabled: true,
          aspectRatioPickerButtonHidden: true,
          cancelButtonTitle: 'Cancelar',
          doneButtonTitle: 'Confirmar',
          resetButtonHidden: true,
        ),
      ],
    );
    return croppedFile != null ? File(croppedFile.path) : null;
  }

  void onClickDeleteImage() => image.value = null;

  void _resetFieldValues() {
    titleController.clear();
    descriptionController.clear();
    image.value = null;
    titleFocus.requestFocus();
  }
}
