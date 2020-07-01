export 'user.dart';
export 'authorization_token.dart';
export 'project.dart';
export 'category.dart';
export 'attached_file.dart';
export 'task.dart';
export 'comment.dart';
export 'periodicity.dart';
export 'session.dart';
export 'task_log.dart';

int jsonStringToInt(String value) =>
    (value == null || value == "") ? null : int.parse(value);

String jsonIntToString(int value) =>
    (value == null || value == 0) ? null : value.toString();

String jsonDateTimeToISO(DateTime value) =>
    (value == null) ? null : value.toUtc().toIso8601String();
