import 'package:flutter/material.dart';
import 'package:task_accent/ui/helpers/helpers.dart';
import '../shared.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../tasks/task_preview.dart';

class ProjectPage extends StatefulWidget {
  final int id;
  ProjectPage(this.id);
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  StreamSubscription projectSubscription;
  Project project;
  ProjectService projectService = ProjectService(GetIt.I<Store>());

  @override
  void initState() {
    super.initState();

    projectSubscription = projectService.listen((proj) {
      setState(() => project = proj);
    });
    fetch();
  }

  fetch() async {
    try {
      await projectService.get(id: widget.id);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    projectSubscription.cancel();
  }

  onUpdate() async {
    try {
      await projectService.get(id: widget.id);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: appBar('Project'),
      drawer: drawer(context),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: project != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(project.name),
                    SizedBox(height: 8.0),
                    Text('Tasks'),
                    ListView(
                        shrinkWrap: true,
                        children: project.tasks
                            .map((task) => TaskPreviewWidget(task, onUpdate))
                            .toList()),
                  ],
                )
              : Loading(),
        ),
      ),
    );
  }
}
