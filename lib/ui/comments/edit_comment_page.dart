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
    });
    commentsSubscription = commentService.listenList((list) {
      widget.onUpdate();
      Navigator.pop(context);
    });

    if (widget.id > 0)
      fetch();
    else
      comment = Comment(
          taskId: widget.taskId,
          isSolution: widget.isSolution,
          attachedFiles: []);
  }

  fetch() async {
    try {
      await commentService.get(id: widget.id);
    } catch (e) {
      setState(() => error = e.toString());
    }
  }

  onFilesChange(List<AttachedFile> files) =>
      setState(() => comment?.attachedFiles = files);

  onSave() async {
    comment.contents = _contentsController.text;
    try {
      if (widget.id > 0)
        await commentService.update(comment);
      else
        await commentService.create(comment);
    } catch (e) {
      setState(() => error = e.toString());
    }
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
    return AccentScaffold(
      appBar: appBar(widget.id > 0 ? 'Edit Comment' : 'New Comment'),
      drawer: drawer(context),
      body: SafeArea(
        child: comment != null
            ? ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  MaterialInput(
                    controller: _contentsController,
                    autofocus: true,
                    minLines: 3,
                    maxLines: 10,
                    label: 'Your comment',
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
                      PrimaryButton(text: 'Save', onPressed: onSave),
                      DefaultButton(
                        text: 'Cancel',
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                ],
              )
            : Loading(),
      ),
    );
  }
}
