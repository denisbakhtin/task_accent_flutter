import 'package:flutter/material.dart';
import 'fade_route.dart';
import '../pages.dart';
import '../../services/services.dart';

Drawer drawer(BuildContext context) {
  ThemeData theme = Theme.of(context);
  var store = GetIt.I<Store>();

  return Drawer(
    // Add a ListView to the drawer. This ensures the user can scroll
    // through the options in the Drawer if there isn't enough vertical
    // space to fit everything.
    child: Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
      ),
      child: ListTileTheme(
        style: ListTileStyle.drawer,
        textColor: theme.primaryTextTheme.caption.color,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              child: store.isAuthenticated
                  ? SafeArea(
                      child: Container(
                        height: 130.0,
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Image.asset("images/account_photo.png",
                                    height: 50.0),
                                InkWell(
                                  child: Icon(Icons.settings,
                                      color:
                                          theme.primaryTextTheme.caption.color),
                                  onTap: () {
                                    Navigator.pop(context); //close drawer
                                    /* Navigator.push(
                                        context,
                                        FadeRoute(
                                            builder: (context) =>
                                                UserSettingsPage()),
                                      ); */
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              store.authenticatedUser.email,
                              style: theme.textTheme.bodyText2.copyWith(
                                  color: theme.primaryTextTheme.caption.color),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(height: 0.0),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RaisedButton(
                  splashColor: theme.primaryColorLight,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  color: theme.accentColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.playlist_add),
                      SizedBox(width: 8.0),
                      Text('TASK'),
                    ],
                  ),
                  shape: StadiumBorder(),
                  onPressed: () {
                    Navigator.pop(context); //close drawer
                    Navigator.push(
                      context,
                      FadeRoute(
                          builder: (context) => EditTaskPage(0, () => null)),
                    );
                  },
                ),
              ),
            ),
            ListTile(
              title: Row(children: [
                SizedBox(width: 8.0),
                Icon(
                  Icons.home,
                  color: theme.primaryTextTheme.caption.color,
                ),
                SizedBox(width: 16.0),
                Text('Home'),
              ]),
              onTap: () {
                Navigator.pop(context); //close drawer
                Navigator.push(
                  context,
                  FadeRoute(builder: (context) => HomePage()),
                );
              },
            ),
            ListTile(
              title: Row(children: [
                SizedBox(width: 8.0),
                Icon(
                  Icons.view_list,
                  color: theme.primaryTextTheme.caption.color,
                ),
                SizedBox(width: 16.0),
                Text('Projects'),
              ]),
              onTap: () {
                Navigator.pop(context); //close drawer
                Navigator.push(
                  context,
                  FadeRoute(builder: (context) => ProjectsPage()),
                );
              },
            ),
            ListTile(
              title: Row(children: [
                SizedBox(width: 8.0),
                Icon(
                  Icons.list,
                  color: theme.primaryTextTheme.caption.color,
                ),
                SizedBox(width: 16.0),
                Text('Tasks'),
              ]),
              onTap: () {
                Navigator.pop(context); //close drawer
                Navigator.push(
                  context,
                  FadeRoute(builder: (context) => TasksPage()),
                );
              },
            ),
            ListTile(
              title: Row(children: [
                SizedBox(width: 8.0),
                Icon(
                  Icons.category,
                  color: theme.primaryTextTheme.caption.color,
                ),
                SizedBox(width: 16.0),
                Text('Categories'),
              ]),
              onTap: () {
                Navigator.pop(context); //close drawer
                Navigator.push(
                  context,
                  FadeRoute(builder: (context) => CategoriesPage()),
                );
              },
            ),
            ListTile(
              title: Row(children: [
                SizedBox(width: 8.0),
                Icon(
                  Icons.calendar_today,
                  color: theme.primaryTextTheme.caption.color,
                ),
                SizedBox(width: 16.0),
                Text('Spent report'),
              ]),
              onTap: () {
                Navigator.pop(context); //close drawer
                Navigator.push(
                  context,
                  FadeRoute(builder: (context) => SpentPage()),
                );
              },
            ),
            ListTile(
              title: Row(children: [
                SizedBox(width: 8.0),
                Icon(
                  Icons.check_box,
                  color: theme.primaryTextTheme.caption.color,
                ),
                SizedBox(width: 16.0),
                Text('Sessions'),
              ]),
              onTap: () {
                Navigator.pop(context); //close drawer
                Navigator.push(
                  context,
                  FadeRoute(builder: (context) => SessionsPage()),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
              child: Divider(
                color: theme.primaryColorLight,
              ),
            ),
            ListTile(
              title: Row(children: [
                SizedBox(width: 8.0),
                Icon(
                  Icons.exit_to_app,
                  color: theme.primaryTextTheme.caption.color,
                ),
                SizedBox(width: 16.0),
                Text('Logout'),
              ]),
              onTap: () {
                Navigator.pop(context); //close drawer
                Navigator.push(
                  context,
                  FadeRoute(builder: (context) => LogoutPage()),
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}
