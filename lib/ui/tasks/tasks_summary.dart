import 'package:flutter/material.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../pages.dart';
import '../shared.dart';

class TasksSummaryWidget extends StatefulWidget {
  TasksSummaryWidget({Key key}) : super(key: key);

  @override
  TasksSummaryWidgetState createState() => TasksSummaryWidgetState();
}

class TasksSummaryWidgetState extends State<TasksSummaryWidget> {
  TaskService taskService = TaskService(GetIt.I<Store>());
  TasksSummary summary = TasksSummary(count: 0);

  @override
  void initState() {
    super.initState();

    fetch();
  }

  fetch() async {
    var _summary = await taskService.getSummary();
    setState(() => summary = _summary);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: () => Navigator.push(
        context,
        FadeRoute(builder: (context) => TasksPage()),
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
                'Tasks',
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
