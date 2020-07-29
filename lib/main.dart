import 'ui/pages.dart';
import 'package:flutter/material.dart';
import 'services/services.dart';
//import 'package:local_notifications/local_notifications.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'ui/shared.dart';
import 'models/models.dart';
import 'blocs/blocs.dart';

final getIt = GetIt.instance;

void main() async {
  // perform long-running tasks before "runApp" to display the native splash screen
  //initFirebase();
  final store = Store();
  getIt.registerSingleton<Store>(store, signalsReady: true);
  getIt.registerSingleton<UserBloc>(UserBloc(UserService(store)),
      signalsReady: true);
  getIt.registerSingleton<ActiveTaskBloc>(
      ActiveTaskBloc(ActiveTaskService(store)),
      signalsReady: true);

  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> {
  UserBloc userBloc = getIt<UserBloc>();
  ActiveTaskBloc activeTaskBloc = getIt<ActiveTaskBloc>();

  @override
  void dispose() {
    super.dispose();
    userBloc.dispose();
    activeTaskBloc.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Task Accent',
        theme: taskAccentTheme(context),
        home: StreamBuilder<User>(
          stream: userBloc.user,
          builder: (context, snapshot) =>
              (snapshot.data != null) ? HomePage() : LoginPage(),
        ),
      );
}
