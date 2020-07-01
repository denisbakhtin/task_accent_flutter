import 'dart:async';
import '../models/models.dart';
import 'service_controller.dart';
import 'store.dart';

class TaskLogService extends ServiceController<TaskLog> {
  final Store store;
  TaskLogService(this.store) : super(store);

  Future<TaskLog> create(TaskLog taskLog, {String url}) async {
    return await super.create(taskLog, url: "/api/task_logs");
  }

  Future<TaskLog> update(TaskLog taskLog, {String url}) async {
    return await super.update(taskLog, url: "/api/task_logs/${taskLog.id}");
  }
}
