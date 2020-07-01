import 'package:flutter/material.dart';
import '../shared.dart';
import '../../services/services.dart';
import '../../models/models.dart';

class EditCommentPage extends StatefulWidget {
  final int id;
  final int taskId;
  final Function onUpdate;
  final isSolution;
  EditCommentPage(this.id, this.taskId, this.onUpdate,
      {this.isSolution = false});
  @override
  _EditCommentPageState createState() => _EditCommentPageState();
}

class _EditCommentPageState extends State<EditCommentPage> {
  CommentService commentService;
  StreamSubscription commentSubscription;
  StreamSubscription commentsSubscription;
  Comment comment;
  String error;
  TextEditingController _contentsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    commentService = CommentService(GetIt.I<Store>());

    commentSubscription = commentService.listen((com) {
      setState(() {
        error = null;
        if (com != null) {
          comment = com;
          _contentsController.text = comment.contents;
          comment.attachedFiles ??= [];
        }
      });
    }, onError: (Object err) {
      setState(() => error = err.toString());
    });
    commentsSubscription = commentService.listenList((list) {
      widget.onUpdate();
      Navigator.pop(context);
    }, onError: (Object err) {
      setState(() => error = err.toString());
    });

    if (widget.id > 0)
      commentService.get(id: widget.id);
    else
      comment = Comment(taskId: widget.taskId, isSolution: widget.isSolution);
  }

  onFilesChange(List<AttachedFile> files) =>
      setState(() => comment?.attachedFiles = files);

  onSave() async {
    comment.contents = _contentsController.text;
    if (widget.id > 0)
      await commentService.update(comment);
    else
      await commentService.create(comment);
  }

  @override
  void dispose() {
    super.dispose();
    commentSubscription.cancel();
    commentsSubscription.cancel();
    _contentsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: appBar(widget.id > 0 ? 'Edit Comment' : 'New Comment'),
      drawer: drawer(context),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: comment != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Material(
                      child: TextField(
                        controller: _contentsController,
                        autofocus: true,
                        minLines: 3,
                        maxLines: 10,
                        decoration: InputDecoration(
                          labelText: 'Your comment',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    SwitchListTile(
                      title: Text('Is solution'),
                      value: comment.isSolution,
                      onChanged: (val) =>
                          setState(() => comment.isSolution = val),
                    ),
                    SizedBox(height: 8.0),
                    AttachedFilesWidget(comment?.attachedFiles, onFilesChange),
                    Error(error),
                    Row(
                      children: <Widget>[
                        MaterialButton(child: Text('Save'), onPressed: onSave),
                        MaterialButton(
                          child: Text('Cancel'),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ),
                  ],
                )
              : Loading(),
        ),
      ),
    );
  }
}
