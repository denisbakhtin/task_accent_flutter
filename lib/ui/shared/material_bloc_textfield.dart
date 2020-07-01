import 'package:flutter/material.dart';

//TODO: add textfield controller support
class BlocTextField extends StatelessWidget {
  final Stream<String> stream;
  final Function(String) onChanged;
  final String label;
  final bool required;
  final TextInputType keyboardType;
  BlocTextField(this.stream, this.onChanged,
      {this.label, this.required, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StreamBuilder<String>(
          stream: stream,
          builder: (context, snapshot) {
            return TextField(
              onChanged: onChanged,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                labelText: label + (this.required ?? false ? " *" : ""),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(8.0),
              ),
            );
          }),
    );
  }
}
