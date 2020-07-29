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
  SessionService sessionService = SessionService(GetIt.I<Store>());

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    var _menu = PopupMenuButton(
      icon: Icon(Icons.more_vert),
      elevation: 16,
      onSelected: (value) {
        switch (value) {
          case 'Delete':
            showYesNoDialog(context, 'Are you sure?', () async {
              try {
                await sessionService.delete(widget.session);
                widget.onUpdate();
              } catch (e) {
                showSnackbar(context, e.toString());
              }
            });
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(value: 'Delete', child: Text('Delete')),
      ],
    );

    return Container(
      color: theme.canvasColor,
      child: ListTile(
        title: Text("Session #${widget.session.id}"),
        subtitle: (widget.session.contents.length > 0)
            ? Text(
                widget.session.contents,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: _menu,
        onTap: () => Navigator.push(
          context,
          FadeRoute(builder: (context) => SessionPage(widget.session.id)),
        ),
      ),
    );
  }
}
