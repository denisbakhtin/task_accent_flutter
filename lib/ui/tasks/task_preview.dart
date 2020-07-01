import 'package:flutter/material.dart';
import '../shared.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../pages.dart';
import '../helpers/helpers.dart';

class TaskPreviewWidget extends StatefulWidget {
  final Task task;
  final Function onUpdate;
  TaskPreviewWidget(this.task, this.onUpdate);

  @override
  _TaskPreviewWidgetState createState() => _TaskPreviewWidgetState();
}

class _TaskPreviewWidgetState extends State<TaskPreviewWidget> {
  TaskService taskService;

  @override
  void initState() {
    super.initState();

    taskService = TaskService(GetIt.I<Store>());
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    var _menu = PopupMenuButton(
      icon: Icon(Icons.menu),
      elevation: 16,
      onSelected: (value) {
        switch (value) {
          case 'Edit':
            Navigator.push(
              context,
              FadeRoute(
                  builder: (context) =>
                      EditTaskPage(widget.task.id, widget.onUpdate)),
            );
            break;
          case 'Comment':
            Navigator.push(
              context,
              FadeRoute(
                  builder: (context) =>
                      EditCommentPage(0, widget.task.id, widget.onUpdate)),
            );
            break;
          case 'Solve':
            Navigator.push(
              context,
              FadeRoute(
                  builder: (context) => EditCommentPage(
                      0, widget.task.id, widget.onUpdate,
                      isSolution: true)),
            );
            break;
          case 'Delete':
            showYesNoDialog(context, 'Are you sure?', () async {
              await taskService.delete(widget.task);
              widget.onUpdate();
            });
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 'Edit', child: Text('Edit')),
        PopupMenuItem(value: 'Comment', child: Text('Comment')),
        PopupMenuItem(value: 'Solve', child: Text('Solve')),
        PopupMenuItem(value: 'Delete', child: Text('Delete')),
      ],
    );

    return ListTile(
      title: Text(widget.task.name),
      trailing: _menu,
      onTap: () => Navigator.push(
        context,
        FadeRoute(builder: (context) => TaskPage(widget.task.id)),
      ),
    );
  }
}
