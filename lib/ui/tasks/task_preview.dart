import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_accent/blocs/blocs.dart';
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
  TaskService taskService = TaskService(GetIt.I<Store>());
  ActiveTaskBloc activeTaskBloc = GetIt.I<ActiveTaskBloc>();

  onStart(BuildContext context) async {
    try {
      await activeTaskBloc.start(TaskLog.fromTask(widget.task));
    } on SocketException catch (_) {
      showSnackbar(context, "No internet connection.");
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    var _menu = PopupMenuButton(
      icon: Icon(Icons.more_vert),
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

    Widget subtitle() {
      List<Widget> items = [];
      if ((widget.task.taskLogs?.length ?? 0) > 0) {
        items.add(Icon(
          Icons.timelapse,
          color: theme.textTheme.bodyText1.color,
          size: 13,
        ));
        items.add(SizedBox(width: 2));
        items.add(Text(
          humanTaskSpent(widget.task, false),
          style: theme.textTheme.caption,
        ));
        items.add(SizedBox(width: 8));
      }

      if (widget.task.isExpired) {
        items.add(Text(
          'expired',
          style: theme.textTheme.caption
              .copyWith(backgroundColor: theme.primaryColorLight),
        ));
        items.add(SizedBox(width: 8));
      }
      return items.length > 0 ? Row(children: items) : null;
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(
            left: BorderSide(
                color: priorityColor(widget.task.priority), width: 5)),
        color: theme.canvasColor,
      ),
      child: ListTile(
        title: Text(
          widget.task.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: subtitle(),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.play_arrow,
                color: theme.primaryColor,
              ),
              onPressed: () => onStart(context),
            ),
            _menu,
          ],
        ),
        onTap: () => Navigator.push(
          context,
          FadeRoute(builder: (context) => TaskPage(widget.task.id)),
        ),
      ),
    );
  }
}
