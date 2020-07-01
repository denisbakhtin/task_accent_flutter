import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  DatePicker(this.initialDate, this.onSelectDate, this.labelText, {Key key})
      : super(key: key);

  final DateTime initialDate;
  final Function(DateTime) onSelectDate;
  final String labelText;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (picked != null && picked != initialDate) onSelectDate(picked);
  }

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => _selectDate(context),
        child: InputDecorator(
          decoration: InputDecoration(
              labelText: labelText,
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(8.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(initialDate != null
                  ? DateFormat.yMMMd().format(initialDate)
                  : ''),
              Icon(Icons.arrow_drop_down,
                  color: Theme.of(context).primaryColorLight),
            ],
          ),
        ),
      );
}
