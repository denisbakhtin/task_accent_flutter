import 'ui/pages.dart';
import 'package:flutter/material.dart';
import 'services/services.dart';
//import 'package:local_notifications/local_notifications.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'ui/shared.dart';
import 'models/models.dart';

final getIt = GetIt.instance;

void main() async {
  // perform long-running tasks before "runApp" to display the native splash screen
  //initFirebase();
  final store = Store();
  getIt.registerSingleton<Store>(store, signalsReady: true);
  getIt.registerSingleton<UserService>(UserService(store), signalsReady: true);
  getIt.registerSingleton<ActiveTaskService>(ActiveTaskService(store),
      signalsReady: true);

  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> {
  UserService userService;
  StreamSubscription userSubscription;
  User user;

  @override
  void initState() {
    super.initState();
    userService = getIt<UserService>();
    userService.loadPersistentUser();

    userSubscription = userService.listen((u) {
      setState(() {
        user = u;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    userSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Task Accent',
        theme: taskAccentTheme(context),
        home: (user != null) ? HomePage() : LoginPage(),
      );
}
