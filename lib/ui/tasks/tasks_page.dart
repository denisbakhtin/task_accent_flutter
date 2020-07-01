import 'package:flutter/material.dart';
import '../shared.dart';
import 'dart:async';
import 'package:get_it/get_it.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../pages.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  StreamSubscription tasksSubscription;
  List<Task> tasks = [];
  TaskService taskService = TaskService(GetIt.I<Store>());
  String error;

  @override
  void initState() {
    super.initState();

    tasksSubscription = taskService.listenList((list) {
      setState(() {
        error = null;
        tasks = list ?? [];
      });
    }, onError: (Object err) {
      setState(() => error = err.toString());
    });
    taskService.getList();
  }

  @override
  void dispose() {
    super.dispose();
    tasksSubscription.cancel();
  }

  onUpdate() => taskService.getList();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: appBar('Tasks'),
      drawer: drawer(context),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(context,
              FadeRoute(builder: (context) => EditTaskPage(0, onUpdate)))),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: 64.0),
          children:
              tasks.map((task) => TaskPreviewWidget(task, onUpdate)).toList(),
        ),
      ),
    );
  }
}
