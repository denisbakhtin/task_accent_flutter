import 'package:task_accent/models/models.dart';

import '../services/services.dart';
import 'package:rxdart/rxdart.dart';
import 'base_bloc.dart';

class UserBloc implements BaseBloc {
  final UserService _service;

  final _userController = BehaviorSubject<User>();

  Function(User) get userChanged => _userController.sink.add;

  Stream<User> get user => _userController.stream;

  UserBloc(this._service) {
    loadAuthenticatedUser();
  }

  login(String email, String password) async {
    var _user = await _service.login(email, password);
    userChanged(_user);
  }

  logout() async {
    await _service.logout();
    userChanged(null);
  }

  loadAuthenticatedUser() async {
    var _user = await _service.loadPersistentUser();
    _userController.add(_user);
  }

  void dispose() {
    _userController?.close();
  }
}
