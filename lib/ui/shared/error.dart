import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  final String error;
  Error(this.error);

  @override
  Widget build(BuildContext context) {
    return error != null
        ? Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
            child: Center(
              child: Text(error),
            ),
          )
        : SizedBox(height: 0);
  }
}
