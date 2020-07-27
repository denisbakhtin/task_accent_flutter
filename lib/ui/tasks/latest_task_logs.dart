import 'package:flutter/material.dart';
import 'package:task_accent/ui/helpers/helpers.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../pages.dart';
import '../shared.dart';

class LatestTaskLogsWidget extends StatefulWidget {
  LatestTaskLogsWidget({Key key}) : super(key: key);

  @override
  LatestTaskLogsWidgetState createState() => LatestTaskLogsWidgetState();
}

class LatestTaskLogsWidgetState extends State<LatestTaskLogsWidget> {
  TaskLogService taskLogService;
  List<TaskLog> taskLogs = [];

  @override
  void initState() {
    super.initState();

    taskLogService = TaskLogService(GetIt.I<Store>());
    fetch();
  }

  fetch() async {
    var latest = await taskLogService.getLatest();
    setState(() {
      taskLogs = latest;
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
            child: Text('Recently run tasks',
                style: theme.textTheme.headline6.copyWith(fontSize: 18)),
          ),
          ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 8),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: taskLogs?.length ?? 0,
            separatorBuilder: (context, index) => ListDivider(),
            itemBuilder: (context, index) => ListTile(
              title: Text(taskLogs[index].task.name),
              trailing: Text(humanSpent(taskLogs[index].minutes, false)),
              onTap: () => Navigator.push(
                context,
                FadeRoute(
                    builder: (context) => TaskPage(taskLogs[index].taskId)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
