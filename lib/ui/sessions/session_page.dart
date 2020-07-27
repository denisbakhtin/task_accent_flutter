import 'package:flutter/material.dart';
import 'package:task_accent/ui/helpers/helpers.dart';
import '../shared.dart';
import '../../services/services.dart';
import '../../models/models.dart';

class SessionPage extends StatefulWidget {
  final int id;
  SessionPage(this.id);
  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  StreamSubscription sessionSubscription;
  Session session;
  List<TaskLog> logs = [];
  List<Project> projects = [];
  SessionService sessionService = SessionService(GetIt.I<Store>());

  @override
  void initState() {
    super.initState();

    sessionSubscription = sessionService.listen((s) {
      setState(() {
        if (s != null) {
          session = s;
          logs = session.taskLogs;
          projects = groupLogsByProject(logs);
        }
      });
    });
    fetch();
  }

  fetch() async {
    try {
      await sessionService.get(id: widget.id);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    sessionSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AccentScaffold(
      appBar: appBar('Session'),
      drawer: drawer(context),
      body: SafeArea(
        child: session != null
            ? RefreshIndicator(
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: [
                    Text('Session #${session.id}',
                        style: theme.textTheme.headline6),
                    SizedBox(height: 8),
                    session.contents.length > 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(session.contents),
                              SizedBox(height: 8),
                            ],
                          )
                        : SizedBox(height: 0),
                    ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: projects
                          .map(
                            (project) => Card(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(project.name,
                                        style: theme.textTheme.headline6
                                            .copyWith(fontSize: 18)),
                                    ListView(
                                      shrinkWrap: true,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      physics: NeverScrollableScrollPhysics(),
                                      children: project.tasks
                                          .map((task) => Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(task.name,
                                                      style: theme
                                                          .textTheme.caption
                                                          .copyWith(
                                                              fontSize: 14)),
                                                  Text(
                                                      humanTaskSpent(
                                                          task, false),
                                                      style: theme
                                                          .textTheme.caption
                                                          .copyWith(
                                                              fontSize: 14)),
                                                ],
                                              ))
                                          .toList(),
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total',
                                            style: theme.textTheme.headline6
                                                .copyWith(fontSize: 16),
                                          ),
                                          Text(
                                            humanProjectSpent(project, false),
                                            style: theme.textTheme.headline6
                                                .copyWith(fontSize: 16),
                                          ),
                                        ]),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    Card(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Total', style: theme.textTheme.headline6),
                              Text(humanAllProjectsSpent(projects, false),
                                  style: theme.textTheme.headline6),
                            ],
                          )),
                    ),
                  ],
                ),
                onRefresh: () => fetch(),
              )
            : Loading(),
      ),
    );
  }
}
