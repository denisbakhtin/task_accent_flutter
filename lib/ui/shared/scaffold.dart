import 'package:flutter/material.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../shared.dart';

class AccentScaffold extends StatefulWidget {
  final Key key;
  final PreferredSizeWidget appBar;
  final Widget body;
  final Widget floatingActionButton;
  final Widget drawer;
  final String error;
  final Function refresh;
  AccentScaffold(
      {this.key,
      this.appBar,
      this.body,
      this.floatingActionButton,
      this.drawer,
      this.error,
      this.refresh});

  @override
  _AccentScaffoldState createState() => _AccentScaffoldState();
}

class _AccentScaffoldState extends State<AccentScaffold> {
  ActiveTaskService activeTaskService;
  StreamSubscription atSubscription;
  TaskLog taskLog;

  @override
  void initState() {
    super.initState();
    activeTaskService = GetIt.I<ActiveTaskService>();
    taskLog = activeTaskService.activeTaskLog;

    atSubscription = activeTaskService.listen((tl) {
      setState(() {
        taskLog = tl;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    atSubscription.cancel();
  }

  List<Widget> buildChildren() {
    return (widget.error == null)
        ? [
            widget.body,
            ActiveTaskWidget(taskLog, activeTaskService),
          ]
        : [
            Column(children: [
              SizedBox(height: 24),
              Error(widget.error),
              if (widget.refresh != null)
                PrimaryButton(
                  text: 'Refresh',
                  onPressed: () => widget.refresh(),
                ),
            ]),
          ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.key,
      appBar: widget.appBar,
      floatingActionButton: widget.floatingActionButton,
      drawer: widget.drawer,
      body: Stack(
        overflow: Overflow.visible,
        children: buildChildren(),
      ),
    );
  }
}
