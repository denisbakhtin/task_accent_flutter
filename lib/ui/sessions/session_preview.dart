import 'package:flutter/material.dart';
import '../shared.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../pages.dart';
import '../helpers/helpers.dart';

class SessionPreviewWidget extends StatefulWidget {
  final Session session;
  final Function onUpdate;
  SessionPreviewWidget(this.session, this.onUpdate);

  @override
  _SessionPreviewWidgetState createState() => _SessionPreviewWidgetState();
}

class _SessionPreviewWidgetState extends State<SessionPreviewWidget> {
  SessionService sessionService;

  @override
  void initState() {
    super.initState();

    sessionService = SessionService(GetIt.I<Store>());
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    var _menu = PopupMenuButton(
      icon: Icon(Icons.menu),
      elevation: 16,
      onSelected: (value) {
        switch (value) {
          case 'Delete':
            showYesNoDialog(context, 'Are you sure?', () async {
              await sessionService.delete(widget.session);
              widget.onUpdate();
            });
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 'Delete', child: Text('Delete')),
      ],
    );

    return ListTile(
      title: Text("Session #${widget.session.id}"),
      subtitle: Text(widget.session.contents),
      trailing: _menu,
      onTap: () => Navigator.push(
        context,
        FadeRoute(builder: (context) => SessionPage(widget.session.id)),
      ),
    );
  }
}
