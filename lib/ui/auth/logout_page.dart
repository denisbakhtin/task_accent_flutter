import 'package:flutter/material.dart';
import 'package:task_accent/blocs/blocs.dart';
import '../shared.dart';
import '../../services/services.dart';

class LogoutPage extends StatelessWidget {
  final userBloc = GetIt.I<UserBloc>();

  void onLogoutPressed(BuildContext context) async {
    await userBloc.logout();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return AccentScaffold(
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
                PrimaryButton(
                  text: 'LOGOUT',
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
