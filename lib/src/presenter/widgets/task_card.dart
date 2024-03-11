import 'package:flutter/material.dart';
import 'package:wizard_guide/src/domain/entities/entities.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.onPressed,
    required this.task,
  });
  final VoidCallback onPressed;
  final Task task;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: Theme.of(context).textTheme.headlineSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Visibility(
                visible: task.imageUrl.isNotEmpty,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image(
                        image: NetworkImage(task.imageUrl),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                task.description,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}