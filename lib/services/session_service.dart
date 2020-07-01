import 'dart:async';
import '../models/models.dart';
import 'service_controller.dart';
import 'store.dart';
import 'package:meta/meta.dart';

class SessionService extends ServiceController<Session> {
  final Store store;
  SessionService(this.store) : super(store);

  Future<List<Session>> getList({String url}) async {
    return await super.getList(url: '/api/sessions');
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
}
