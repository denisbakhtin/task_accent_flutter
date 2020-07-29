import 'dart:async';
import '../models/models.dart';
import 'services.dart';
import 'store.dart';

class TaskService {
  final Store store;
  TaskService(this.store);

  Future<List<Task>> getList() async {
    var request = Request<Task>(store);
    return await request.getList('/api/tasks');
  }

  Future<Task> get(int id) async {
    var request = Request<Task>(store);
    return await request.get('/api/tasks/$id');
  }

  Future<Task> create(Task task) async {
    var request = Request<Task>(store);
    return await request.post('/api/tasks', task);
  }

  Future<Task> update(Task task) async {
    var request = Request<Task>(store);
    return await request.put("/api/tasks/${task.id}", task);
  }

  delete(Task task) async {
    var request = Request<Task>(store);
    await request.delete("/api/tasks/${task.id}");
  }

  Future<TasksSummary> getSummary() async {
    var request = Request<TasksSummary>(store);
    return await request.get('/api/tasks_summary');
  }

  Future<List<Task>> getLatest() async {
    var request = Request<Task>(store);
    return await request.getList('/api/tasks_latest');
  }
}
