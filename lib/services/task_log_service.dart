import 'dart:async';
import '../models/models.dart';
import 'services.dart';
import 'store.dart';

class TaskLogService {
  final Store store;
  TaskLogService(this.store);

  Future<TaskLog> create(TaskLog log) async {
    var request = Request<TaskLog>(store);
    return await request.post('/api/task_logs', log);
  }

  Future<TaskLog> update(TaskLog log) async {
    var request = Request<TaskLog>(store);
    return await request.put("/api/task_logs/${log.id}", log);
  }

  Future<List<TaskLog>> getLatest() async {
    var request = Request<TaskLog>(store);
    return await request.getList('/api/task_logs_latest');
  }
}
