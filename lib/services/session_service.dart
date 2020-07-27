import 'dart:async';
import '../models/models.dart';
import 'service_controller.dart';
import 'services.dart';
import 'store.dart';
import 'package:meta/meta.dart';

class SessionService extends ServiceController<Session> {
  final Store store;
  SessionService(this.store) : super(store);

  Future<List<Session>> getList({String url}) async {
    return await super.getList(url: '/api/sessions');
  }

  Future<Session> getNew() async {
    return await super.get(url: '/api/new_session');
  }

  Future<Session> get({@required int id, String url}) async {
    return await super.get(id: id, url: '/api/sessions/$id');
  }

  Future<Session> create(Session session, {String url}) async {
    return await super.create(session, url: "/api/sessions");
  }

  delete(Session session, {String url}) async {
    return await super.delete(session, url: '/api/sessions/${session.id}');
  }

  Future<SessionsSummary> getSummary() async {
    var req = new Request.get("/api/sessions_summary");
    var response = await req.executeUserRequest(store);

    switch (response.statusCode) {
      case 200:
        {
          var summary = new SessionsSummary.fromJson(response.body);
          return summary;
        }
        break;

      default:
        throw (response.body is Map<String, dynamic>)
            ? response.body["error"]
            : response.body;
    }
  }
}
