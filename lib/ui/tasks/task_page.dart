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

  @override
  void initState() {
    super.initState();

    taskService = TaskService(store);
    taskSubscription = taskService.listen((proj) {
      setState(() => task = proj);
    });
    fetch();
  }

  fetch() async {
    try {
      await taskService.get(id: widget.id);
    } catch (e) {
      showSnackbar(context, e.toString());
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
    return Scaffold(
      appBar: appBar('Task'),
      drawer: drawer(context),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: task != null
              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(task.name),
                  SizedBox(height: 8.0),
                  AttachedFilesWidget(task.attachedFiles, null),
                  SizedBox(height: 8.0),
                  Text('Comments'),
                  MaterialButton(
                    child: Text('Add Comment'),
                    onPressed: () => Navigator.push(
                      context,
                      FadeRoute(
                          builder: (context) =>
                              EditCommentPage(0, task.id, onUpdate)),
                    ),
                  ),
                  ListView(
                      shrinkWrap: true,
                      children: task.comments
                          .map((comment) =>
                              CommentPreviewWidget(comment, onUpdate))
                          .toList()),
                ])
              : Loading(),
        ),
      ),
    );
  }
}
