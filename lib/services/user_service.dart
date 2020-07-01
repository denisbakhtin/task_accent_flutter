import 'dart:async';
import '../models/models.dart';
import 'service_controller.dart';
import 'http.dart';
import 'store.dart';

class UserService extends ServiceController<User> {
  final Store store;
  UserService(this.store) : super(store);

  logout() async {
    await store.logout();
    add(null);
  }

  loadPersistentUser() async {
    await store.loadPersistentData();
    add(store.authenticatedUser);
  }

  Future<User> login(String email, String password) async {
    var req = new Request.post("/api/login", {
      "email": email,
      "password": password,
    });

    var response = await req.executeRequest(store);
    if (response.error != null) {
      addError(response.error);
      return null;
    }

    switch (response.statusCode) {
      case 200:
        var token = AuthorizationToken.fromJson(response.body);
        store.token = token.token;
        return getAuthenticatedUser();
      default:
        addError(new APIError(response.body["error"]));
    }

    return null;
  }

  Future<User> register(String email, String password) async {
    var req =
        new Request.post("/register", {"email": email, "password": password});

    var response = await req.executeRequest(store);
    if (response.error != null) {
      addError(response.error);
      return null;
    }

    switch (response.statusCode) {
      case 200:
        return getAuthenticatedUser();
      case 409:
        addError(new APIError("User already exists"));
        break;
      default:
        addError(new APIError(response.body["error"]));
    }

    return null;
  }

  Future<User> getAuthenticatedUser() async {
    var req = new Request.get("/api/account");
    var response = await req.executeUserRequest(store);

    if (response.error != null) {
      addError(response.error);
      return null;
    }

    switch (response.statusCode) {
      case 200:
        {
          var user = new User.fromJson(response.body);
          store.authenticatedUser = user;
          add(user);

          return user;
        }
        break;

      default:
        addError(new APIError(response.body["error"]));
    }

    return null;
  }
}
