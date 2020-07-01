import 'package:flutter/material.dart';
import '../../models/models.dart';

class PriorityDropdownWidget extends StatelessWidget {
  final int value;
  final Function(int value) setPriority;
  PriorityDropdownWidget(this.value, this.setPriority, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
        isExpanded: true, //prevents overflow
        value: value,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        onChanged: (int newValue) => setPriority(newValue),
        items: [
          DropdownMenuItem(value: PRIORITY1, child: Text('Do Now')),
          DropdownMenuItem(value: PRIORITY2, child: Text('Do Next')),
          DropdownMenuItem(value: PRIORITY3, child: Text('Do Later')),
          DropdownMenuItem(value: PRIORITY4, child: Text('Do Last')),
        ]);
  }
}
