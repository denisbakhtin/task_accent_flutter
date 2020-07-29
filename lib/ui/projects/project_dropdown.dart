import 'package:flutter/material.dart';
import 'package:task_accent/ui/helpers/helpers.dart';
import '../../models/models.dart';
import '../../services/services.dart';

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
  List<Project> projects = [];

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
    return (projects.length > 0)
        ? DropdownButton<int>(
            isExpanded: true, //prevents overflow
            value: widget.value,
            hint: Text('Project...'),
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
