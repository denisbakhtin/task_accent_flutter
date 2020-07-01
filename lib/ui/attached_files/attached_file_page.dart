import 'package:flutter/material.dart';

class AttachedFilePage extends StatefulWidget {
  final String path;
  AttachedFilePage(this.path);
  @override
  _AttachedFilePageState createState() => _AttachedFilePageState();
}

class _AttachedFilePageState extends State<AttachedFilePage> {
  String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Hero(
            tag: 'imageHero',
            child: Image.network(widget.path),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
