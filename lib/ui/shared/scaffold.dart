import 'package:flutter/material.dart';
import 'package:task_accent/blocs/blocs.dart';
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
  ActiveTaskBloc activeTaskBloc = GetIt.I<ActiveTaskBloc>();
  TaskLog taskLog;

  List<Widget> buildChildren() {
    return (widget.error == null)
        ? [
            widget.body,
            ActiveTaskWidget(activeTaskBloc),
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
