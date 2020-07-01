import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import 'dart:async';

class ProjectDropdownWidget extends StatefulWidget {
  final int value;
  final Function(int value) setProjectId;
  ProjectDropdownWidget(this.value, this.setProjectId, {Key key})
      : super(key: key);

  @override
  _ProjectDropdownWidgetState createState() => _ProjectDropdownWidgetState();
}

class _ProjectDropdownWidgetState extends State<ProjectDropdownWidget> {
  ProjectService projectService = ProjectService(GetIt.I<Store>());
  StreamSubscription projectsSubscription;
  List<Project> projects = [];

  @override
  void initState() {
    super.initState();

    projectsSubscription = projectService.listenList((list) {
      setState(() => projects = list ?? []);
    }, onError: (Object err) {});
    projectService.getList();
  }

  @override
  void dispose() {
    super.dispose();
    projectsSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return (projects.length > 0)
        ? DropdownButton<int>(
            isExpanded: true, //prevents overflow
            value: widget.value,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            onChanged: (int newValue) {
              widget.setProjectId(newValue);
            },
            items: projects
                .map((project) => DropdownMenuItem<int>(
                    value: project.id,
                    child: Text(
                      project.name,
                      overflow: TextOverflow.ellipsis,
                    )))
                .toList(),
          )
        : SizedBox(height: 0);
  }
}
