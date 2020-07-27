import 'package:flutter/material.dart';

class MaterialInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autofocus;
  final String label;
  final int minLines;
  final int maxLines;
  MaterialInput({
    this.controller,
    this.autofocus: false,
    this.label,
    this.minLines: 1,
    this.maxLines: 1,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextField(
        controller: controller,
        autofocus: autofocus,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(8.0),
        ),
      ),
    );
  }
}
