import 'package:flutter/material.dart';
import 'package:task_accent/ui/categories/categories_summary.dart';
import 'package:task_accent/ui/projects/projects_summary.dart';
import 'package:task_accent/ui/sessions/sessions_summary.dart';
import 'package:task_accent/ui/tasks/latest_task_logs.dart';
import 'package:task_accent/ui/tasks/latest_tasks.dart';
import 'package:task_accent/ui/tasks/tasks_summary.dart';
import '../shared.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ProjectsSummaryWidgetState> _projectsKey = GlobalKey();
  final GlobalKey<TasksSummaryWidgetState> _tasksKey = GlobalKey();
  final GlobalKey<CategoriesSummaryWidgetState> _categoriesKey = GlobalKey();
  final GlobalKey<SessionsSummaryWidgetState> _sessionsKey = GlobalKey();
  final GlobalKey<LatestTasksWidgetState> _latestTasksKey = GlobalKey();
  final GlobalKey<LatestTaskLogsWidgetState> _latestTaskLogsKey = GlobalKey();

  update() async {
    await _projectsKey.currentState.fetch();
    await _tasksKey.currentState.fetch();
    await _categoriesKey.currentState.fetch();
    await _sessionsKey.currentState.fetch();
    await _latestTasksKey.currentState.fetch();
    await _latestTaskLogsKey.currentState.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return AccentScaffold(
      appBar: appBar('Task Accent'),
      drawer: drawer(context),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: RefreshIndicator(
            onRefresh: () => update(),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(height: 16.0),
                Text('Welcome to Task Accent.'),
                SizedBox(height: 8.0),
                Row(
                  children: <Widget>[
                    Expanded(child: ProjectsSummaryWidget(key: _projectsKey)),
                    SizedBox(width: 8),
                    Expanded(child: TasksSummaryWidget(key: _tasksKey)),
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: CategoriesSummaryWidget(key: _categoriesKey)),
                    SizedBox(width: 8),
                    Expanded(child: SessionsSummaryWidget(key: _sessionsKey)),
                  ],
                ),
                SizedBox(height: 8.0),
                LatestTasksWidget(key: _latestTasksKey),
                SizedBox(height: 8.0),
                LatestTaskLogsWidget(key: _latestTaskLogsKey),
                SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
