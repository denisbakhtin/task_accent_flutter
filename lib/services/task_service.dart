import 'dart:async';
import '../models/models.dart';
import 'service_controller.dart';
import 'services.dart';
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

  Future<TasksSummary> getSummary() async {
    var req = new Request.get("/api/tasks_summary");
    var response = await req.executeUserRequest(store);

    switch (response.statusCode) {
      case 200:
        {
          var summary = new TasksSummary.fromJson(response.body);
          return summary;
        }
        break;

      default:
        throw (response.body is Map<String, dynamic>)
            ? response.body["error"]
            : response.body;
    }
  }

  Future<List<Task>> getLatest() async {
    var req = new Request.get("/api/tasks_latest");
    var response = await req.executeUserRequest(store);

    switch (response.statusCode) {
      case 200:
        {
          var list = (response.body as List<dynamic>)
              .map((o) => Task.fromJson(o))
              .toList();
          return list;
        }
        break;

      default:
        throw (response.body is Map<String, dynamic>)
            ? response.body["error"]
            : response.body;
    }
  }
}
