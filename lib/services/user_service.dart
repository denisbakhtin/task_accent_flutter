import 'dart:async';
import '../models/models.dart';
import 'http.dart';
import 'store.dart';

class UserService {
  final Store store;
  UserService(this.store);

  logout() async {
    await store.logout();
  }

  Future<User> loadPersistentUser() async {
    await store.loadPersistentData();
    return store.authenticatedUser;
  }

  Future<User> login(String email, String password) async {
    var request = Request<AuthorizationToken>(store);
    var token = await request.post(
        '/api/login', LoginModel(email: email, password: password));

    store.token = token.token;
    return getAuthenticatedUser();
  }

  //Register via web site atm... not sure why :)
  Future<User> register(String email, String password) async {
    var request = Request<AuthorizationToken>(store);
    var token = await request.post(
        '/api/register', LoginModel(email: email, password: password));

    store.token = token.token;
    return getAuthenticatedUser();
  }

  Future<User> getAuthenticatedUser() async {
    var request = Request<User>(store);
    var user = await request.get('/api/account');
    store.authenticatedUser = user;
    return user;
  }
}
