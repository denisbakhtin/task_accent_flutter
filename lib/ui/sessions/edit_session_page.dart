import 'package:flutter/material.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../shared.dart';

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
  Session session;
  String error;
  TextEditingController _contentsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    sessionService = SessionService(GetIt.I<Store>());
    sessionSubscription = sessionService.listen((t) {
      setState(() {
        error = null;
        if (t != null) {
          session = t;
          _contentsController.text = session.contents;
          session.taskLogs ??= [];
        }
      });
    }, onError: (Object err) {
      setState(() => error = err.toString());
    });
    //service's create and update methods, write into List streams
    sessionsSubscription = sessionService.listenList((list) {
      widget.onUpdate(); //fire callback to refresh list
      Navigator.pop(context);
    }, onError: (Object err) {
      setState(() => error = err.toString());
    });

    session = Session();
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
    await sessionService.create(session);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: appBar('New Session'),
      drawer: drawer(context),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Material(
                child: TextField(
                  controller: _contentsController,
                  autofocus: true,
                  minLines: 2,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Comment',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Error(error),
              Row(
                children: <Widget>[
                  MaterialButton(child: Text('Save'), onPressed: onSave),
                  MaterialButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
