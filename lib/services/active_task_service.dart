import 'dart:async';
import '../models/models.dart';
import 'http.dart';
import 'store.dart';

class ActiveTaskService {
  final Store store;
  ActiveTaskService(this.store);

  Future<TaskLog> start(TaskLog taskLog) async {
    var request = Request<TaskLog>(store);
    return await request.post('/api/task_logs', taskLog);
  }

  //TODO: catch exceptions??
  Future<TaskLog> update(TaskLog taskLog) async {
    var request = Request<TaskLog>(store);
    return await request.put("/api/task_logs/${taskLog.id}", taskLog);
  }
}
