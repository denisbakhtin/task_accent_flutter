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

    projectService = ProjectService(GetIt.I<Store>());
    projectSubscription = projectService.listen((proj) {
      setState(() {
        error = null;
        if (proj != null) {
          project = proj;
          _nameController.text = project.name;
          _descriptionController.text = project.description;
          project.attachedFiles ??= [];
        }
      });
    });

    projectsSubscription = projectService.listenList((list) {
      widget.onUpdate();
      Navigator.pop(context);
    });

    if (widget.id > 0)
      fetch();
    else
      project = Project();
  }

  fetch() async {
    try {
      await projectService.get(id: widget.id);
    } catch (e) {
      setState(() => error = e.toString());
    }
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
    try {
      if (widget.id > 0)
        await projectService.update(project);
      else
        await projectService.create(project);
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
