import 'package:flutter/material.dart';
import 'package:task_accent/ui/helpers/helpers.dart';
import '../shared.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../tasks/task_preview.dart';
import '../pages.dart';

class ProjectPage extends StatefulWidget {
  final int id;
  ProjectPage(this.id);
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  Project project;
  ProjectService projectService = ProjectService(GetIt.I<Store>());

  @override
  void initState() {
    super.initState();

    fetch();
  }

  fetch() async {
    try {
      var _project = await projectService.get(widget.id);
      setState(() => project = _project);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AccentScaffold(
      appBar: appBar('Project'),
      drawer: drawer(context),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(
              context,
              FadeRoute(
                  builder: (context) =>
                      EditTaskPage(0, fetch, projectId: project.id)))),
      body: SafeArea(
        child: project != null
            ? RefreshIndicator(
                child: ListView(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 64),
                  children: [
                    Text(project.name, style: theme.textTheme.headline6),
                    SizedBox(height: 8),
                    if (project.description?.isNotEmpty ?? false)
                      Text(project.description,
                          style: theme.textTheme.bodyText1),
                    if (project.description?.isNotEmpty ?? false)
                      SizedBox(height: 8),
                    AttachedFilesWidget(project.attachedFiles, null),
                    SizedBox(height: 8.0),
                    Text('Tasks', style: theme.textTheme.subtitle1),
                    SizedBox(height: 8.0),
                    Container(
                      color: theme.canvasColor,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: project.tasks?.length ?? 0,
                        itemBuilder: (context, index) =>
                            TaskPreviewWidget(project.tasks[index], fetch),
                        separatorBuilder: (context, index) => ListDivider(),
                      ),
                    ),
                  ],
                ),
                onRefresh: () => fetch(),
              )
            : Loading(),
      ),
    );
  }
}
