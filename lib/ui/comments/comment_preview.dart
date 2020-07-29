import 'package:flutter/material.dart';
import '../shared.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../pages.dart';
import '../helpers/helpers.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CommentPreviewWidget extends StatefulWidget {
  final Comment comment;
  final Function onUpdate;
  CommentPreviewWidget(this.comment, this.onUpdate);

  @override
  _CommentPreviewWidgetState createState() => _CommentPreviewWidgetState();
}

class _CommentPreviewWidgetState extends State<CommentPreviewWidget> {
  CommentService commentService = CommentService(GetIt.I<Store>());

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
                  builder: (context) => EditCommentPage(widget.comment.id,
                      widget.comment.taskId, widget.onUpdate)),
            );
            break;
          case 'Delete':
            showYesNoDialog(context, 'Are you sure?', () async {
              await commentService.delete(widget.comment);
              widget.onUpdate();
            });
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 'Edit', child: Text('Edit')),
        PopupMenuItem(value: 'Delete', child: Text('Delete')),
      ],
    );

    return ListTile(
      title: MarkdownBody(data: widget.comment.contents),
      subtitle: (widget.comment.attachedFiles?.length ?? 0) > 0
          ? AttachedFilesWidget(widget.comment.attachedFiles, null)
          : null,
      trailing: _menu,
      dense: true,
    );
  }
}
