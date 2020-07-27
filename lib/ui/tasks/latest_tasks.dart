import 'package:flutter/material.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../pages.dart';
import '../shared.dart';

class LatestTasksWidget extends StatefulWidget {
  LatestTasksWidget({Key key}) : super(key: key);

  @override
  LatestTasksWidgetState createState() => LatestTasksWidgetState();
}

class LatestTasksWidgetState extends State<LatestTasksWidget> {
  TaskService taskService;
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();

    taskService = TaskService(GetIt.I<Store>());
    fetch();
  }

  fetch() async {
    var latest = await taskService.getLatest();
    setState(() {
      tasks = latest;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Latest tasks',
                style: theme.textTheme.headline6.copyWith(fontSize: 18)),
          ),
          ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 8),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: tasks?.length ?? 0,
            separatorBuilder: (context, index) => ListDivider(),
            itemBuilder: (context, index) =>
                TaskPreviewWidget(tasks[index], () => null),
          ),
        ],
      ),
    );
  }
}
