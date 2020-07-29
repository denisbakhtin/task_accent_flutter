import 'package:task_accent/models/models.dart';

import '../services/services.dart';
import 'package:rxdart/rxdart.dart';
import 'base_bloc.dart';

class ActiveTaskBloc implements BaseBloc {
  final ActiveTaskService _service;
  Timer _timer;
  DateTime _startedAt;
  TaskLog _activeTaskLog;

  final _logController = BehaviorSubject<TaskLog>();

  Function(TaskLog) get _logChanged => _logController.sink.add;

  Stream<TaskLog> get log => _logController.stream;

  ActiveTaskBloc(this._service);

  start(TaskLog taskLog) async {
    if (_activeTaskLog != null) await stop();
    _activeTaskLog = await _service.start(taskLog);
    _logChanged(_activeTaskLog);
    _startedAt = DateTime.now();
    _timer = Timer.periodic(Duration(minutes: 1), (timer) => update());
  }

  update() async {
    _activeTaskLog.minutes = DateTime.now().difference(_startedAt).inMinutes;
    if (_activeTaskLog.minutes == 0 &&
        DateTime.now().difference(_startedAt).inSeconds > 15)
      _activeTaskLog.minutes = 1;

    _activeTaskLog = await _service.update(_activeTaskLog);
    _logChanged(_activeTaskLog);
  }

  stop() async {
    try {
      await update();
    } finally {
      _timer?.cancel();
      _activeTaskLog = null;
      _startedAt = null;
      _logChanged(null);
    }
  }

  void dispose() {
    _timer?.cancel();
    _logController?.close();
  }
}
