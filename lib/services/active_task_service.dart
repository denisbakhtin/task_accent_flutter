import 'dart:async';
import '../models/models.dart';
import 'service_controller.dart';
import 'store.dart';

class ActiveTaskService extends ServiceController<TaskLog> {
  final Store store;
  Timer timer;
  DateTime startedAt;
  TaskLog activeTaskLog;
  ActiveTaskService(this.store) : super(store);

  Future<TaskLog> start(TaskLog taskLog, {String url}) async {
    if (activeTaskLog != null) await stop(activeTaskLog);
    var res = await super.create(taskLog, url: "/api/task_logs");
    add(res);
    activeTaskLog = res;
    startedAt = DateTime.now();
    timer =
        Timer.periodic(Duration(minutes: 1), (timer) => update(activeTaskLog));
    return res;
  }

  //TODO: catch exceptions??
  Future<TaskLog> update(TaskLog taskLog, {String url}) async {
    activeTaskLog.minutes = DateTime.now().difference(startedAt).inMinutes;
    if (activeTaskLog.minutes == 0 &&
        DateTime.now().difference(startedAt).inSeconds > 15)
      activeTaskLog.minutes = 1;
    return await super
        .update(activeTaskLog, url: "/api/task_logs/${activeTaskLog.id}");
  }

  Future<TaskLog> stop(TaskLog taskLog, {String url}) async {
    try {
      await update(taskLog);
    } finally {
      timer?.cancel();
      add(null);
      activeTaskLog = null;
      startedAt = null;
    }
    return null;
  }
}
