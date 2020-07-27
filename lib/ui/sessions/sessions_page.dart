import 'package:flutter/material.dart';
import 'package:task_accent/ui/helpers/helpers.dart';
import '../shared.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import 'session_preview.dart';
import 'edit_session_page.dart';

class SessionsPage extends StatefulWidget {
  @override
  _SessionsPageState createState() => _SessionsPageState();
}

class _SessionsPageState extends State<SessionsPage> {
  StreamSubscription sessionsSubscription;
  List<Session> sessions = [];
  SessionService sessionService = SessionService(GetIt.I<Store>());

  @override
  void initState() {
    super.initState();

    sessionsSubscription = sessionService.listenList((list) {
      setState(() => sessions = list ?? []);
    });
    fetch();
  }

  fetch() async {
    try {
      await sessionService.getList();
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void onUpdate() async {
    try {
      await sessionService.getList();
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
      appBar: appBar('Sessions'),
      drawer: drawer(context),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(context,
              FadeRoute(builder: (context) => EditSessionPage(onUpdate)))),
      body: SafeArea(
        child: RefreshIndicator(
          child: ListView.separated(
            padding: EdgeInsets.only(bottom: 64),
            shrinkWrap: true,
            separatorBuilder: (context, index) => ListDivider(),
            itemCount: sessions?.length ?? 0,
            itemBuilder: (context, index) =>
                SessionPreviewWidget(sessions[index], onUpdate),
          ),
          onRefresh: () => fetch(),
        ),
      ),
    );
  }
}
