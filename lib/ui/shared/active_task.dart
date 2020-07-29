import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_accent/blocs/blocs.dart';
import 'package:task_accent/ui/helpers/helpers.dart';
import '../../models/models.dart';
import '../pages.dart';
import '../shared.dart';

class ActiveTaskWidget extends StatelessWidget {
  final ActiveTaskBloc activeTaskBloc;

  ActiveTaskWidget(this.activeTaskBloc);

  void onStop(BuildContext context) async {
    try {
      await activeTaskBloc.stop();
    } on SocketException catch (_) {
      showSnackbar(
          context, 'No internet connection, last tracking ticks may be lost!');
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return StreamBuilder<TaskLog>(
        stream: activeTaskBloc.log,
        builder: (context, snapshot) {
          return snapshot.data != null
              ? Column(
                  mainAxisAlignment:
                      MainAxisAlignment.end, // start at end/bottom of column
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(width: 16),
                          IconButton(
                            icon: Icon(Icons.pause),
                            onPressed: () => onStop(context),
                            color: theme.scaffoldBackgroundColor,
                            splashColor: theme.accentColor,
                          ),
                          RawMaterialButton(
                            padding: EdgeInsets.all(4),
                            onPressed: () => Navigator.push(
                              context,
                              FadeRoute(
                                  builder: (context) =>
                                      TaskPage(snapshot.data.taskId)),
                            ),
                            child: Text(
                              snapshot.data.task.name,
                              style: TextStyle(color: Color(0xFFFFFFFF)),
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : SizedBox(height: 0);
        });
  }
}
