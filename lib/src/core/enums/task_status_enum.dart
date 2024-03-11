// ignore_for_file: constant_identifier_names



enum TaskStatusENUM { PENDING, IN_PROGRESS, FINISHED }

final Map<String, TaskStatusENUM?> toTaskStatusENUM = {
  'Pendiente': TaskStatusENUM.PENDING,
  'En Progreso': TaskStatusENUM.IN_PROGRESS,
  'Finalizada': TaskStatusENUM.FINISHED,
};

final Map<TaskStatusENUM, String> toTaskString = {
  TaskStatusENUM.PENDING: 'Pendiente',
  TaskStatusENUM.IN_PROGRESS: 'En Progreso',
  TaskStatusENUM.FINISHED: 'Finalizada',
};
