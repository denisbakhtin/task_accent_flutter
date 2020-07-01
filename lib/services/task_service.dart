import 'dart:async';
import '../models/models.dart';
import 'service_controller.dart';
import 'store.dart';
import 'package:meta/meta.dart';

class TaskService extends ServiceController<Task> {
  final Store store;
  TaskService(this.store) : super(store);

  Future<List<Task>> getList({String url}) async {
    return await super.getList(url: '/api/tasks');
  }

  Future<Task> get({@required int id, String url}) async {
    return await super.get(id: id, url: '/api/tasks/$id');
  }

  Future<Task> create(Task task, {String url}) async {
    return await super.create(task, url: "/api/tasks");
  }

  Future<Task> update(Task task, {String url}) async {
    return await super.update(task, url: "/api/tasks/${task.id}");
  }

  delete(Task task, {String url}) async {
    return await super.delete(task, url: '/api/tasks/${task.id}');
  }
}
