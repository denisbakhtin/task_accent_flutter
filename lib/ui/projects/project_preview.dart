import 'package:flutter/material.dart';
import '../shared.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../pages.dart';
import '../helpers/helpers.dart';

class ProjectPreviewWidget extends StatefulWidget {
  final Project project;
  final Function onUpdate;
  ProjectPreviewWidget(this.project, this.onUpdate);

  @override
  _ProjectPreviewWidgetState createState() => _ProjectPreviewWidgetState();
}

class _ProjectPreviewWidgetState extends State<ProjectPreviewWidget> {
  ProjectService projectService;

  @override
  void initState() {
    super.initState();

    projectService = ProjectService(GetIt.I<Store>());
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    var _menu = PopupMenuButton(
      icon: Icon(Icons.more_vert),
      elevation: 16,
      onSelected: (value) {
        if (value == "Edit")
          Navigator.push(
            context,
            FadeRoute(
                builder: (context) =>
                    EditProjectPage(widget.project.id, widget.onUpdate)),
          );
        if (value == "Delete")
          showYesNoDialog(context, 'Are you sure?', () async {
            await projectService.delete(widget.project);
            widget.onUpdate();
          });
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 'Edit', child: Text('Edit')),
        PopupMenuItem(value: 'Delete', child: Text('Delete')),
      ],
    );

    return Container(
      color: theme.canvasColor,
      child: ListTile(
        title: Text(
          widget.project.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: _menu,
        onTap: () => Navigator.push(
          context,
          FadeRoute(builder: (context) => ProjectPage(widget.project.id)),
        ),
      ),
    );
  }
}
