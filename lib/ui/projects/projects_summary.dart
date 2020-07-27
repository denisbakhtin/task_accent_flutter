import 'package:flutter/material.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../pages.dart';
import '../shared.dart';

class ProjectsSummaryWidget extends StatefulWidget {
  ProjectsSummaryWidget({Key key}) : super(key: key);

  @override
  ProjectsSummaryWidgetState createState() => ProjectsSummaryWidgetState();
}

class ProjectsSummaryWidgetState extends State<ProjectsSummaryWidget> {
  ProjectService projectService;
  ProjectsSummary summary = ProjectsSummary(count: 0);

  @override
  void initState() {
    super.initState();

    projectService = ProjectService(GetIt.I<Store>());
    fetch();
  }

  fetch() async {
    var sum = await projectService.getSummary();
    setState(() {
      summary = sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: () => Navigator.push(
        context,
        FadeRoute(builder: (context) => ProjectsPage()),
      ),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(summary.count.toString(), style: theme.textTheme.headline6),
              SizedBox(height: 8),
              Text(
                'Projects',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
