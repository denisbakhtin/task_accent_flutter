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
  TaskService taskService;
  TasksSummary summary = TasksSummary(count: 0);

  @override
  void initState() {
    super.initState();

    taskService = TaskService(GetIt.I<Store>());
    fetch();
  }

  fetch() async {
    var sum = await taskService.getSummary();
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
