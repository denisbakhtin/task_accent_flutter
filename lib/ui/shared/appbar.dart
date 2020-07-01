import 'package:flutter/material.dart';
import '../../ui/helpers/helpers.dart';

AppBar appBar(String title, {PopupMenuButton popupMenu}) => AppBar(
      brightness: Brightness.light,
      title: Text(title),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.notifications),
          tooltip: 'Notifications',
          onPressed: null,
        ),
        popupMenu,
      ].where(notNull).toList(),
    );
