import 'package:flutter/material.dart';
import '../../services/services.dart';
import '../../models/models.dart';
import '../pages.dart';
import '../shared.dart';

class SessionsSummaryWidget extends StatefulWidget {
  SessionsSummaryWidget({Key key}) : super(key: key);

  @override
  SessionsSummaryWidgetState createState() => SessionsSummaryWidgetState();
}

class SessionsSummaryWidgetState extends State<SessionsSummaryWidget> {
  SessionService sessionService;
  SessionsSummary summary = SessionsSummary(count: 0);

  @override
  void initState() {
    super.initState();

    sessionService = SessionService(GetIt.I<Store>());
    fetch();
  }

  fetch() async {
    var sum = await sessionService.getSummary();
    setState(() {
      summary = sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return InkWell(
      onTap: () => Navigator.push(
        context,
        FadeRoute(builder: (context) => SessionsPage()),
      ),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(summary.count.toString(), style: theme.textTheme.headline6),
              SizedBox(height: 8),
              Text(
                'Sessions',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
