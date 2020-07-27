import 'package:flutter/material.dart';
import '../helpers/helpers.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import '../../services/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../shared.dart';

const registerUrl = baseURL + "/#!/register";

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserService _userService = GetIt.I<UserService>();
  //GlobalBloc _globalBloc;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  bool obscurePassword;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  String error;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    obscurePassword = true;
    seedControllers();
  }

  void seedControllers() async {
    _emailController.text = "denis.bakhtin@gmail.com";
    _passwordController.text = "12345678";
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void toggleObscure() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  void onSubmit(BuildContext context) async {
    try {
      await _userService.login(_emailController.text, _passwordController.text);
    } catch (e) {
      setState(() => error = e.toString());
    }
  }

  _launchURL(String path) async {
    if (await canLaunch(path)) {
      await launch(path);
    } else {
      setState(() => error = "Can't open url $path");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double maxWidth = min(screenSize.height, screenSize.width);
    bool isLandscape = screenSize.width > screenSize.height;
    ThemeData theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          child: Center(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              shrinkWrap: true,
              children: <Widget>[
                Center(
                  child: Image.asset("images/logo.png", width: maxWidth / 2.5),
                ),
                SizedBox(height: 8.0),
                isLandscape
                    ? SizedBox(width: 0)
                    : Center(child: Text('Task Accent')),
                isLandscape
                    ? SizedBox(width: 0)
                    : SizedBox(height: isLandscape ? 16.0 : 42.0),
                Material(
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Material(
                  child: TextField(
                    obscureText: obscurePassword,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                      suffixIcon: IconButton(
                        onPressed: toggleObscure,
                        iconSize: 16.0,
                        icon: Icon(Icons.visibility),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Builder(
                    //need Builder wrapper for snackbar to work, see https://medium.com/@ksheremet/flutter-showing-snackbar-within-the-widget-that-builds-a-scaffold-3a817635aeb2
                    builder: (context) => FlatButton(
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(color: theme.accentColor),
                      ),
                      onPressed: () => showSnackbar(context, notImplemented),
                    ),
                  ),
                ),
                Error(error),
                SizedBox(height: 8.0),
                PrimaryButton(
                  padding: EdgeInsets.all(16.0),
                  text: 'LOGIN',
                  onPressed: () => onSubmit(context),
                ),
                SizedBox(height: isLandscape ? 16.0 : 36.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: theme.primaryColor),
                    ),
                    SizedBox(width: 10.0),
                    Builder(
                      builder: (context) => InkWell(
                        child: Text(
                          'Create',
                          style: TextStyle(color: theme.accentColor),
                        ),
                        onTap: () => _launchURL(registerUrl),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
