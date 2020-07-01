import 'package:flutter/material.dart';
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
  SessionService sessionService = SessionService(GetIt.I<Store>());
  String error;

  @override
  void initState() {
    super.initState();

    sessionSubscription = sessionService.listen((proj) {
      setState(() {
        error = null;
        session = proj;
      });
    }, onError: (Object err) {
      setState(() => error = err.toString());
    });
    sessionService.get(id: widget.id);
  }

  @override
  void dispose() {
    super.dispose();
    sessionSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: appBar('Session'),
      drawer: drawer(context),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Text('Session #${session?.id}' ?? "Loading"),
        ),
      ),
    );
  }
}
