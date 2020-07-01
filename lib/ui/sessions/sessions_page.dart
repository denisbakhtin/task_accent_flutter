import 'package:flutter/material.dart';
import 'package:task_accent/ui/helpers/helpers.dart';
import '../shared.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import 'session_preview.dart';

class SessionsPage extends StatefulWidget {
  @override
  _SessionsPageState createState() => _SessionsPageState();
}

class _SessionsPageState extends State<SessionsPage> {
  StreamSubscription sessionsSubscription;
  List<Session> sessions = [];
  SessionService sessionService = SessionService(GetIt.I<Store>());
  String error;

  @override
  void initState() {
    super.initState();

    sessionsSubscription = sessionService.listenList((list) {
      setState(() {
        error = null;
        sessions = list ?? [];
      });
    }, onError: (Object err) {
      setState(() => error = err.toString());
      showSnackbar(context, error);
    });
    sessionService.getList();
  }

  void onUpdate() => sessionService.getList();

  @override
  void dispose() {
    super.dispose();
    sessionsSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: appBar('Sessions'),
      drawer: drawer(context),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: sessions
              .map((session) => SessionPreviewWidget(session, onUpdate))
              .toList(),
        ),
      ),
    );
  }
}
