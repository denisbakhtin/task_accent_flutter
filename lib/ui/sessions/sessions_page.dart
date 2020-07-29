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
  List<Session> sessions = [];
  SessionService sessionService = SessionService(GetIt.I<Store>());

  @override
  void initState() {
    super.initState();

    fetch();
  }

  fetch() async {
    try {
      var _sessions = await sessionService.getList();
      setState(() => sessions = _sessions ?? []);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
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
              FadeRoute(builder: (context) => EditSessionPage(fetch)))),
      body: SafeArea(
        child: RefreshIndicator(
          child: ListView.separated(
            padding: EdgeInsets.only(bottom: 64),
            shrinkWrap: true,
            separatorBuilder: (context, index) => ListDivider(),
            itemCount: sessions?.length ?? 0,
            itemBuilder: (context, index) =>
                SessionPreviewWidget(sessions[index], fetch),
          ),
          onRefresh: () => fetch(),
        ),
      ),
    );
  }
}
