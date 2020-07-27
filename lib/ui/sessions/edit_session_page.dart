import 'package:flutter/material.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../shared.dart';
import '../helpers/helpers.dart';

class EditSessionPage extends StatefulWidget {
  final Function onUpdate;
  EditSessionPage(this.onUpdate);
  @override
  _EditSessionPageState createState() => _EditSessionPageState();
}

class _EditSessionPageState extends State<EditSessionPage> {
  SessionService sessionService;
  StreamSubscription sessionSubscription;
  StreamSubscription sessionsSubscription;
  Session session = Session(taskLogs: []);
  List<Project> projects;
  String error;
  Map<int, Task> commitedTasks = {};
  TextEditingController _contentsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    sessionService = SessionService(GetIt.I<Store>());
    sessionSubscription = sessionService.listen((t) {
      setState(() {
        error = null;
        if (t != null) {
          projects = groupLogsByProject(t.taskLogs);
        }
      });
    });
    //service's create and update methods, write into List streams
    sessionsSubscription = sessionService.listenList((list) {
      widget.onUpdate(); //fire callback to refresh list
      Navigator.pop(context);
    });

    sessionService.getNew();
  }

  @override
  void dispose() {
    super.dispose();
    sessionSubscription.cancel();
    sessionsSubscription.cancel();
    _contentsController.dispose();
  }

  void onSave() async {
    session.contents = _contentsController.text;
    try {
      session.taskLogs.forEach((log) => log.task = null);
      await sessionService.create(session);
    } catch (e) {
      setState(() => error = e.toString());
    }
  }

  bool projectCommited(project) {
    var val =
        project.tasks?.every((task) => commitedTasks[task.id] != null) ?? false;

    return val;
  }

  commitProject(project) {
    setState(() {
      project.tasks.forEach((task) {
        commitedTasks[task.id] = task;
        task.taskLogs.forEach((log) => session.taskLogs.add(log));
      });
    });
  }

  unCommitProject(project) {
    setState(() {
      project.tasks.forEach((task) {
        commitedTasks.remove(task.id);
        task.taskLogs.forEach((log) => session.taskLogs.remove(log));
      });
    });
  }

  taskCommited(task) => commitedTasks[task.id] != null;
  commitTask(task) {
    setState(() {
      commitedTasks[task.id] = task;
      task.taskLogs.forEach((log) => session.taskLogs.add(log));
    });
  }

  unCommitTask(task) {
    setState(() {
      commitedTasks.remove(task.id);
      task.taskLogs.forEach((log) => session.taskLogs.remove(log));
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AccentScaffold(
      appBar: appBar('New Session'),
      drawer: drawer(context),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          shrinkWrap: true,
          children: <Widget>[
            MaterialInput(
              controller: _contentsController,
              autofocus: true,
              minLines: 2,
              maxLines: 3,
              label: 'Session comment',
            ),
            projects != null
                ? ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 8),
                    children: projects
                        .map(
                          (project) => Card(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SwitchListTile(
                                      title: Text(project.name,
                                          style: theme.textTheme.headline6
                                              .copyWith(fontSize: 18)),
                                      subtitle: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.timelapse,
                                            color:
                                                theme.textTheme.bodyText1.color,
                                            size: 13,
                                          ),
                                          SizedBox(width: 4),
                                          Text(humanProjectSpent(
                                              project, false)),
                                        ],
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 2),
                                      value: projectCommited(project),
                                      onChanged: (val) => val
                                          ? commitProject(project)
                                          : unCommitProject(project)),
                                  ListView(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.only(bottom: 8),
                                    children: project.tasks
                                        .map((task) => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SwitchListTile(
                                                    title: Text(task.name,
                                                        style: theme
                                                            .textTheme.caption
                                                            .copyWith(
                                                                fontSize: 16)),
                                                    subtitle: Row(
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.timelapse,
                                                          color: theme.textTheme
                                                              .bodyText1.color,
                                                          size: 13,
                                                        ),
                                                        SizedBox(width: 4),
                                                        Text(humanTaskSpent(
                                                            task, false)),
                                                      ],
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 0),
                                                    value: taskCommited(task),
                                                    onChanged: (val) => val
                                                        ? commitTask(task)
                                                        : unCommitTask(task)),
                                              ],
                                            ))
                                        .toList(),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  )
                : SizedBox(height: 0),
            Card(
              child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Total', style: theme.textTheme.headline6),
                      Text(humanSessionSpent(session, false),
                          style: theme.textTheme.headline6),
                    ],
                  )),
            ),
            SizedBox(height: 8.0),
            Error(error),
            Row(
              children: <Widget>[
                PrimaryButton(text: 'Save', onPressed: onSave),
                DefaultButton(
                  text: 'Cancel',
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
