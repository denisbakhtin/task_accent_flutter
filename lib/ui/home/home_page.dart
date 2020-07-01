import 'package:flutter/material.dart';
import '../shared.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Task Accent'),
      drawer: drawer(context),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(height: 16.0),
              Text('Welcome to Task Accent.'),
              SizedBox(height: 8.0),
              Text('This page will contain useful widgets.'),
              SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
