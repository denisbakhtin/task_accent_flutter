//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';

//const String tokenKey = 'token';

bool notNull(Object o) => o != null;

const String notImplemented =
    'This feature is not implemented in the demo version';

Type typeOf<T>() => T;

bool stringIsNullOrEmpty(String value) {
  return value == null || value.isEmpty;
}

String dateTimeToIso(DateTime dt) => (dt != null) ? dt.toIso8601String() : null;

String dateTimeToString(DateTime dt) =>
    (dt != null) ? DateFormat('MM/dd/yyyy').format(dt) : "-";

TableRow tableBlankRow(int columns, {double height = 8.0}) => TableRow(
      children: List.generate(
          columns,
          (index) => SizedBox(
                height: height,
              )).toList(),
    );

String formatAsCurrency(double value) =>
    new NumberFormat.simpleCurrency().format(value);

String formatAsDate(DateTime value) => DateFormat('MM/dd/yyyy').format(value);

void showSnackbar(BuildContext context, String text) {
  Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
}

Color priorityColor(int priority) {
  switch (priority) {
    case 1:
      return Color(0xFFdc3545);
    case 2:
      return Color(0xFF00BD89);
    case 3:
      return Color(0xFFe0f5d7);
    default:
      return Color(0x00FFFFFF);
  }
}

List<Project> groupLogsByProject(List<TaskLog> logs) {
  return groupTasksByProjects(groupLogsByTask(logs));
}

List<Task> groupLogsByTask(List<TaskLog> logs) {
  if (logs == null) return [];

  Map<int, Task> tasks = {};
  logs.forEach((log) {
    log.task.taskLogs = List<TaskLog>();
    Task task = tasks[log.task.id] ?? log.task;
    task.taskLogs.add(log);
    tasks[task.id] = task;
  });
  return tasks.values.toList();
}

List<Project> groupTasksByProjects(tasks) {
  if (tasks == null) return [];

  Map<int, Project> projects = {};
  tasks.forEach((task) {
    task.project.tasks = List<Task>();
    Project project = projects[task.project.id] ?? task.project;
    project.tasks.add(task);
    projects[project.id] = project;
  });
  return projects.values.toList();
}

showYesNoDialog(BuildContext context, String text, Function onYes) {
  // set up the buttons
  Widget noButton = FlatButton(
    child: Text("No"),
    onPressed: () => Navigator.pop(context),
  );
  Widget yesButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        if (onYes != null) onYes();
        Navigator.pop(context); //dismiss dialog
      });

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: Text(text),
    actions: [
      yesButton,
      noButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String humanSpent(int minutes, bool long) {
  if (minutes == null || minutes == 0) return '';
  var m = minutes % 60;
  var h = (minutes / 60).floor();
  String res = "";
  if (long)
    res = ((h > 0) ? "$h hours " : "") + ((m > 0) ? "$m minutes" : '');
  else
    res = ((h > 0) ? "${h}h " : "") + ((m > 0) ? "${m}m" : "");

  return res.trim();
}

String humanTaskSpent(Task task, bool long) =>
    humanSpent(taskSpent(task), long);

int taskSpent(Task task) {
  int sum = 0;
  task.taskLogs?.forEach((element) => sum += element.minutes);
  return sum;
}

String humanProjectSpent(Project project, bool long) =>
    humanSpent(projectSpent(project), long);

int projectSpent(Project project) {
  int sum = 0;
  project.tasks?.forEach((element) => sum += taskSpent(element));
  return sum;
}

String humanAllProjectsSpent(List<Project> projects, bool long) {
  projects ??= [];
  int sum = 0;
  projects.forEach((element) => sum += projectSpent(element));
  return humanSpent(sum, long);
}

String humanSessionSpent(Session session, bool long) {
  int sum = 0;
  session.taskLogs?.forEach((element) => sum += element.minutes);
  return humanSpent(sum, long);
}
