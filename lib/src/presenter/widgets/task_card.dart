import 'package:flutter/material.dart';
import 'package:wizard_guide/src/domain/entities/entities.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.onPressed,
    required this.task,
  });
  final VoidCallback onPressed;
  final TaskData task;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.black),
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
                    Hero(
                      tag: task.id,
                      child: AspectRatio(
                        aspectRatio: 1.1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            task.imageUrl,
                            width: size.width,
                            height: size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
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
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black),
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
