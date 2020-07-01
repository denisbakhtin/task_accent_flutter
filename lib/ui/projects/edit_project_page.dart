import 'package:flutter/material.dart';
import '../shared.dart';
import '../../services/services.dart';
import '../../models/models.dart';

class EditProjectPage extends StatefulWidget {
  final int id;
  final ProjectService projectService;
  EditProjectPage(this.id, this.projectService);
  @override
  _EditProjectPageState createState() => _EditProjectPageState();
}

class _EditProjectPageState extends State<EditProjectPage> {
  StreamSubscription projectSubscription;
  StreamSubscription projectsSubscription;
  Project project;
  String error;
  List<Category> categories = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    projectSubscription = widget.projectService.listen((proj) {
      setState(() {
        error = null;
        if (proj != null) {
          project = proj;
          _nameController.text = project.name;
          _descriptionController.text = project.description;
          project.attachedFiles ??= [];
        }
      });
    }, onError: (Object err) {
      setState(() => error = err.toString());
    });

    projectsSubscription = widget.projectService.listenList((list) {
      Navigator.pop(context);
    }, onError: (Object err) {
      setState(() => error = err.toString());
    });

    if (widget.id > 0)
      widget.projectService.get(id: widget.id);
    else
      project = Project();
  }

  @override
  void dispose() {
    super.dispose();
    projectSubscription.cancel();
    projectsSubscription.cancel();
    _nameController.dispose();
    _descriptionController.dispose();
  }

  onFilesChange(List<AttachedFile> files) =>
      setState(() => project?.attachedFiles = files);

  void onSave() async {
    project.name = _nameController.text;
    project.description = _descriptionController.text;
    if (widget.id > 0)
      await widget.projectService.update(project);
    else
      await widget.projectService.create(project);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: appBar(widget.id > 0 ? 'Edit Project' : 'New Project'),
      drawer: drawer(context),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Material(
                child: TextField(
                  controller: _nameController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Material(
                child: TextField(
                  controller: _descriptionController,
                  minLines: 3,
                  maxLines: 10,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                ),
              ),
              CategoryDropdownWidget(project?.categoryId,
                  (int value) => setState(() => project.categoryId = value)),
              SizedBox(height: 8.0),
              AttachedFilesWidget(project?.attachedFiles, onFilesChange),
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
          ),
        ),
      ),
    );
  }
}
