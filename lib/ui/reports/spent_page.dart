import 'package:flutter/material.dart';
import '../pages.dart';
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

  @override
  void initState() {
    super.initState();

    sessionsSubscription = reportService.listenList((list) {
      setState(() {
        logs = list ?? [];
        projects = groupLogsByProject(logs);
      });
    });
    fetch();
  }

  fetch() async {
    try {
      await reportService.getSpent();
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    sessionsSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AccentScaffold(
      appBar: appBar('Time spent report'),
      drawer: drawer(context),
      body: SafeArea(
        child: RefreshIndicator(
          child: ListView(
            padding: EdgeInsets.all(8),
            children: <Widget>[
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: projects
                    .map(
                      (project) => Card(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(project.name,
                                  style: theme.textTheme.headline6),
                              ListView(
                                shrinkWrap: true,
                                padding: EdgeInsets.symmetric(vertical: 8),
                                physics: NeverScrollableScrollPhysics(),
                                children: project.tasks
                                    .map((task) => Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(task.name,
                                                style: theme.textTheme.caption
                                                    .copyWith(fontSize: 14)),
                                            Text(humanTaskSpent(task, false),
                                                style: theme.textTheme.caption
                                                    .copyWith(fontSize: 14)),
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
              SizedBox(height: 8),
              //prevent stretching to full width
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 4),
                  child: PrimaryButton(
                    text: 'New Session',
                    onPressed: () => Navigator.push(
                        context,
                        FadeRoute(
                            builder: (context) => EditSessionPage(() => null))),
                  )),
            ],
          ),
          onRefresh: () => fetch(),
        ),
      ),
    );
  }
}
