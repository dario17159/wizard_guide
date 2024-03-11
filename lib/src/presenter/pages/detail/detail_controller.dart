import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wizard_guide/src/core/enums/enums.dart';
import 'package:wizard_guide/src/core/services/services.dart';
import 'package:wizard_guide/src/data/repositories/api_repository_impl.dart';
import 'package:wizard_guide/src/domain/entities/entities.dart';
import 'package:wizard_guide/src/domain/entities/task_status.dart';
import 'package:wizard_guide/src/domain/repositories/api_repository.dart';

class DetailController extends GetxController {
  final IApiRepository _apiRepository = Get.find<ApiRepositoryImpl>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  late TaskData task;
  Rx<TaskStatus?> statusSelected = Rx<TaskStatus?>(null);
  RxBool canUpdate = false.obs;

  final List<TaskStatus> statusList = [
    TaskStatus(value: 'Pendiente', type: TaskStatusENUM.PENDING),
    TaskStatus(value: 'En Progreso', type: TaskStatusENUM.IN_PROGRESS),
    TaskStatus(value: 'Finalizada', type: TaskStatusENUM.FINISHED),
  ];

  @override
  void onInit() {
    task = Get.arguments as TaskData;
    titleController.text = task.title;
    descriptionController.text = task.description;
    statusSelected.value =
        statusList.where((element) => element.value == task.status.value).first;
    super.onInit();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> onClickConfirmUpdate() async {
    try {
      if (titleController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty) {
        DialogService.showLoading(message: 'Agregando tarea...');
        await _apiRepository
            .updateTask(task.copyWith(status: statusSelected.value));
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

  void onChangeStatus(TaskStatus? status) {
    statusSelected.value = status;
    canUpdate.value = (task.status.type != status!.type);
  }
}
