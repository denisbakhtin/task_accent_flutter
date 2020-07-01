import 'package:flutter/widgets.dart';
import 'package:task_accent/ui/helpers/helpers.dart';

class Messages {
  static showError(BuildContext context, String error) {
    //TODO: do some red styling here
    showSnackbar(context, error);
  }

  static showMessage(BuildContext context, String error) {
    showSnackbar(context, error);
  }
}
