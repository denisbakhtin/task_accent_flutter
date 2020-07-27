import 'dart:io';

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
      setState(() => tasks = list ?? []);
    });
    fetch();
  }

  fetch() async {
    try {
      error = null;
      await taskService.getList();
    } on SocketException catch (_) {
      setState(() => error = "No internet connection");
    } catch (e) {
      setState(() => error = e.toString());
    }
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

    Widget tab(Iterable<Task> filteredTasks) => RefreshIndicator(
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 64),
            separatorBuilder: (context, index) => ListDivider(),
            itemCount: filteredTasks?.length ?? 0,
            itemBuilder: (context, index) =>
                TaskPreviewWidget(filteredTasks.elementAt(index), onUpdate),
          ),
          onRefresh: () => fetch(),
        );

    Widget tabs() => TabBarView(
          children: [
            tab(tasks),
            tab(tasks.where((t) => !t.completed)),
            tab(tasks.where((t) => t.completed)),
            tab(tasks.where((t) => t.isExpired)),
          ],
        );

    return DefaultTabController(
      length: 4,
      child: AccentScaffold(
        appBar: appBar(
          'Tasks',
          bottom: TabBar(
            tabs: [
              Tab(text: 'ALL'),
              Tab(text: 'OPEN'),
              Tab(text: 'CLOSED'),
              Tab(text: 'EXPIRED'),
            ],
          ),
        ),
        drawer: drawer(context),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => Navigator.push(context,
                FadeRoute(builder: (context) => EditTaskPage(0, onUpdate)))),
        error: error,
        refresh: fetch,
        body: SafeArea(
          child: tabs(),
        ),
      ),
    );
  }
}
