import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_accent/ui/helpers/helpers.dart';
import '../shared.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../comments/comment_preview.dart';
import '../pages.dart';

class TaskPage extends StatefulWidget {
  final int id;
  TaskPage(this.id);
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  StreamSubscription taskSubscription;
  Task task;
  Store store = GetIt.I<Store>();
  TaskService taskService;
  ActiveTaskService activeTaskService;
  String error;

  @override
  void initState() {
    super.initState();

    activeTaskService = GetIt.I<ActiveTaskService>();
    taskService = TaskService(store);
    taskSubscription = taskService.listen((proj) {
      setState(() => task = proj);
    });
    fetch();
  }

  fetch() async {
    try {
      error = null;
      await taskService.get(id: widget.id);
    } on SocketException catch (_) {
      setState(() => error = "No internet connection");
    } catch (e) {
      setState(() => error = e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    taskSubscription.cancel();
  }

  onUpdate() => taskService.get(id: widget.id);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AccentScaffold(
      appBar: appBar('Task'),
      drawer: drawer(context),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => activeTaskService.start(TaskLog.fromTask((task)))),
      error: error,
      refresh: fetch,
      body: SafeArea(
        child: task != null
            ? RefreshIndicator(
                child: ListView(padding: EdgeInsets.all(16), children: [
                  Text(task.name, style: theme.textTheme.headline6),
                  SizedBox(height: 8),
                  if (task.description?.isNotEmpty ?? false)
                    Text(task.description, style: theme.textTheme.bodyText1),
                  if (task.description?.isNotEmpty ?? false)
                    SizedBox(height: 8),
                  AttachedFilesWidget(task.attachedFiles, null),
                  SizedBox(height: 8),
                  Text('Comments (${task.comments?.length ?? 0})',
                      style: theme.textTheme.subtitle1),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: PrimaryButton(
                      text: 'Add Comment',
                      onPressed: () => Navigator.push(
                        context,
                        FadeRoute(
                            builder: (context) =>
                                EditCommentPage(0, task.id, onUpdate)),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    color: Color(0x77FFFFFF),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: task.comments?.length ?? 0,
                      itemBuilder: (context, index) =>
                          CommentPreviewWidget(task.comments[index], onUpdate),
                      separatorBuilder: (context, index) => ListDivider(),
                    ),
                  ),
                ]),
                onRefresh: () => fetch(),
              )
            : Loading(),
      ),
    );
  }
}
