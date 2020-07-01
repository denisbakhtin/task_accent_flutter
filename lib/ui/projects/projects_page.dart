import 'package:flutter/material.dart';
import '../shared.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../pages.dart';
import '../helpers/helpers.dart';

class ProjectsPage extends StatefulWidget {
  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  StreamSubscription projectsSubscription;
  List<Project> projects = [];
  ProjectService projectService = ProjectService(GetIt.I<Store>());

  @override
  void initState() {
    super.initState();

    projectsSubscription = projectService.listenList((list) {
      setState(() => projects = list ?? []);
    });
    fetch();
  }

  fetch() async {
    try {
      await projectService.getList();
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    projectsSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: appBar('Projects'),
      drawer: drawer(context),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(
              context,
              FadeRoute(
                  builder: (context) => EditProjectPage(0, projectService)))),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: 64.0),
          children: projects
              .map((project) => ListTile(
                    title: Text(project.name),
                    trailing: _DropDownMenu(project, projectService),
                    onTap: () => Navigator.push(
                      context,
                      FadeRoute(builder: (context) => ProjectPage(project.id)),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class _DropDownMenu extends StatelessWidget {
  final Project project;
  final ProjectService projectService;
  _DropDownMenu(this.project, this.projectService, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.menu),
      elevation: 16,
      onSelected: (value) {
        if (value == "Edit")
          Navigator.push(
            context,
            FadeRoute(
                builder: (context) =>
                    EditProjectPage(project.id, projectService)),
          );
        if (value == "Delete")
          showYesNoDialog(
              context, 'Are you sure?', () => projectService.delete(project));
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 'Edit', child: Text('Edit')),
        PopupMenuItem(value: 'Delete', child: Text('Delete')),
      ],
    );
  }
}
