import 'package:flutter/material.dart';
import '../shared.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../helpers/helpers.dart';

class SpentPage extends StatefulWidget {
  @override
  _SpentPageState createState() => _SpentPageState();
}

class _SpentPageState extends State<SpentPage> {
  StreamSubscription sessionsSubscription;
  List<TaskLog> logs = [];
  List<Project> projects = [];
  ReportService reportService = ReportService(GetIt.I<Store>());
  String error;

  @override
  void initState() {
    super.initState();

    sessionsSubscription = reportService.listenList((list) {
      setState(() {
        error = null;
        logs = list ?? [];
        projects = groupLogsByProject(logs);
      });
    }, onError: (Object err) {
      setState(() => error = err.toString());
    });
    reportService.getSpent();
  }

  @override
  void dispose() {
    super.dispose();
    sessionsSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: appBar('Time spent'),
      drawer: drawer(context),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(8.0),
          children: projects
              .map(
                (project) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(project.name),
                    ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(8.0),
                      children: project.tasks
                          .map((task) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(task.name),
                                ],
                              ))
                          .toList(),
                    )
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
