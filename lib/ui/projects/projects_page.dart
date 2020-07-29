import 'package:flutter/material.dart';
import '../shared.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../pages.dart';
import '../helpers/helpers.dart';
import 'project_preview.dart';

class ProjectsPage extends StatefulWidget {
  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  List<Project> projects = [];
  ProjectService projectService = ProjectService(GetIt.I<Store>());

  @override
  void initState() {
    super.initState();

    fetch();
  }

  fetch() async {
    try {
      var _projects = await projectService.getList();
      setState(() => projects = _projects ?? []);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AccentScaffold(
      appBar: appBar('Projects'),
      drawer: drawer(context),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(context,
              FadeRoute(builder: (context) => EditProjectPage(0, fetch)))),
      body: SafeArea(
        child: RefreshIndicator(
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 64),
            separatorBuilder: (context, index) => ListDivider(),
            itemCount: projects?.length ?? 0,
            itemBuilder: (context, index) =>
                ProjectPreviewWidget(projects[index], fetch),
          ),
          onRefresh: () => fetch(),
        ),
      ),
    );
  }
}
