import 'package:flutter/material.dart';
import '../shared.dart';
import '../../services/services.dart';
import '../../models/models.dart';

class EditProjectPage extends StatefulWidget {
  final int id;
  final Function onUpdate;
  EditProjectPage(this.id, this.onUpdate);
  @override
  _EditProjectPageState createState() => _EditProjectPageState();
}

class _EditProjectPageState extends State<EditProjectPage> {
  ProjectService projectService;
  Project project;
  String error;
  List<Category> categories = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    projectService = ProjectService(GetIt.I<Store>());
    if (widget.id > 0)
      fetch();
    else
      project = Project();
  }

  fetch() async {
    try {
      var _project = await projectService.get(widget.id);
      setState(() {
        error = null;
        if (_project != null) {
          project = _project;
          _nameController.text = project.name;
          _descriptionController.text = project.description;
          project.attachedFiles ??= [];
        }
      });
    } catch (e) {
      setState(() => error = e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
  }

  onFilesChange(List<AttachedFile> files) =>
      setState(() => project?.attachedFiles = files);

  onSave() async {
    project.name = _nameController.text;
    project.description = _descriptionController.text;
    try {
      if (widget.id > 0)
        await projectService.update(project);
      else
        await projectService.create(project);
      widget.onUpdate();
      Navigator.pop(context);
    } catch (e) {
      setState(() => error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AccentScaffold(
      appBar: appBar(widget.id > 0 ? 'Edit Project' : 'New Project'),
      drawer: drawer(context),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            MaterialInput(
              controller: _nameController,
              autofocus: true,
              label: 'Name',
            ),
            SizedBox(height: 8.0),
            MaterialInput(
              controller: _descriptionController,
              minLines: 3,
              maxLines: 10,
              label: 'Description',
            ),
            CategoryDropdownWidget(project?.categoryId,
                (int value) => setState(() => project.categoryId = value)),
            SizedBox(height: 8.0),
            AttachedFilesWidget(project?.attachedFiles, onFilesChange),
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
        ),
      ),
    );
  }
}
