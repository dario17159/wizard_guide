import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wizard_guide/src/core/enums/enums.dart';
import 'package:wizard_guide/src/domain/entities/entities.dart';
import 'package:wizard_guide/src/presenter/pages/detail/detail.dart';
import 'package:wizard_guide/src/presenter/widgets/widgets.dart';

class PendingTaskPage extends StatelessWidget {
  const PendingTaskPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: TaskCard(
          onPressed: () => Get.to(
            () => const DetailPage(),
            binding: DetailBinding(),
            arguments: 'aqui la task',
          ),
          task: Task(
            title: 'title',
            description: 'description',
            imageUrl: '',
            status: TaskStatusENUM.PENDING,
          ),
        ),
      ),
    );
  }
}
