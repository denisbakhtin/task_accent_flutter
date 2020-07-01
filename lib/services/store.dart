import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:corsac_jwt/corsac_jwt.dart';
import '../models/models.dart';
import 'dart:convert';

class Store {
  FlutterSecureStorage storage;
  String get _tokenKey => "token";
  String get _userKey => "user";

  String _token;
  String get token => _token;
  set token(String t) {
    _token = t;
    if (t != null) {
      storage.write(key: _tokenKey, value: token);
    } else {
      storage.delete(key: _tokenKey);
    }
  }

  JWT get parsedToken => _token != null ? JWT.parse(_token) : null;

  bool get isAuthenticated => (_authenticatedUser != null);
  User _authenticatedUser;
  User get authenticatedUser => _authenticatedUser;
  set authenticatedUser(User u) {
    _authenticatedUser = u;
    if (u != null) {
      storage.write(key: _userKey, value: jsonEncode(u.toJson()));
    } else {
      storage.delete(key: _userKey);
    }
  }

  logout() async {
    token = null;
    authenticatedUser = null;
  }

  Store() {
    storage = FlutterSecureStorage();
    //loadPersistentData();
  }

  loadPersistentData() async {
    try {
      _token = await storage.read(key: _tokenKey);
      var u = await storage.read(key: _userKey);
      _authenticatedUser = new User.fromJson(json.decode(u));
    } catch (e) {}
  }
}
