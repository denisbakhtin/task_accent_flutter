import 'package:flutter/material.dart';
import '../shared.dart';
import '../../services/services.dart';

class LogoutPage extends StatelessWidget {
  final userService = GetIt.I<UserService>();

  void onLogoutPressed(BuildContext context) async {
    await userService.logout();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Participants Demo'),
      drawer: drawer(context),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Thank you for using Participants Demo App.'),
                SizedBox(height: 16.0),
                RaisedButton(
                  child: Text('LOGOUT'),
                  onPressed: () => onLogoutPressed(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
