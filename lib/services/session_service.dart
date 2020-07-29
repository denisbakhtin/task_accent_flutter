import '../models/models.dart';
import 'services.dart';
import 'store.dart';

class SessionService {
  final Store store;
  SessionService(this.store);

  Future<List<Session>> getList() async {
    var request = Request<Session>(store);
    return await request.getList('/api/sessions');
  }

  Future<Session> get(int id) async {
    var request = Request<Session>(store);
    return await request.get('/api/sessions/$id');
  }

  Future<Session> getNew() async {
    var request = Request<Session>(store);
    return await request.get('/api/new_session');
  }

  Future<Session> create(Session session) async {
    var request = Request<Session>(store);
    return await request.post('/api/sessions', session);
  }

  Future<Session> update(Session session) async {
    var request = Request<Session>(store);
    return await request.put("/api/sessions/${session.id}", session);
  }

  delete(Session session) async {
    var request = Request<Session>(store);
    await request.delete("/api/sessions/${session.id}");
  }

  Future<SessionsSummary> getSummary() async {
    var request = Request<SessionsSummary>(store);
    return await request.get('/api/sessions_summary');
  }
}
