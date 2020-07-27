import 'dart:async';
import '../models/models.dart';
import 'service_controller.dart';
import 'services.dart';
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

  Future<List<TaskLog>> getLatest() async {
    var req = new Request.get("/api/task_logs_latest");
    var response = await req.executeUserRequest(store);

    switch (response.statusCode) {
      case 200:
        {
          var list = (response.body as List<dynamic>)
              .map((o) => TaskLog.fromJson(o))
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
