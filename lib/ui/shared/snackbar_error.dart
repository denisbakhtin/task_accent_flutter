import 'package:flutter/material.dart';
import 'package:task_accent/ui/helpers/helpers.dart';

//TODO: not sure it works at all
class SnackBarError extends StatelessWidget {
  final String error;
  SnackBarError(this.error);

  @override
  Widget build(BuildContext context) {
    if (error != null) showSnackbar(context, error);
    return SizedBox(height: 0);
  }
}
