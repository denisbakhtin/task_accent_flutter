import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final EdgeInsetsGeometry padding;
  PrimaryButton({
    @required this.text,
    @required this.onPressed,
    this.padding,
  });
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return MaterialButton(
      color: theme.primaryColor,
      onPressed: onPressed,
      padding: padding,
      child: Text(text,
          style: TextStyle(
            color: Color(0xFFFFFFFF),
          )),
    );
  }
}

class AccentButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final EdgeInsetsGeometry padding;
  AccentButton({
    @required this.text,
    @required this.onPressed,
    this.padding,
  });
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return MaterialButton(
      color: theme.accentColor,
      onPressed: onPressed,
      padding: padding,
      child: Text(text,
          style: TextStyle(
            color: Color(0xFFFFFFFF),
          )),
    );
  }
}

class DefaultButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final EdgeInsetsGeometry padding;
  DefaultButton({
    @required this.text,
    @required this.onPressed,
    this.padding,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(text),
      padding: padding,
    );
  }
}
