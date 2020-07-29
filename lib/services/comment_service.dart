import 'dart:async';
import '../models/models.dart';
import 'store.dart';
import 'http.dart';

class CommentService {
  final Store store;
  CommentService(this.store);

  Future<List<Comment>> getList() async {
    var request = Request<Comment>(store);
    return await request.getList('/api/comments');
  }

  Future<Comment> get(int id) async {
    var request = Request<Comment>(store);
    return await request.get('/api/comments/$id');
  }

  Future<Comment> create(Comment comment) async {
    var request = Request<Comment>(store);
    return await request.post('/api/comments', comment);
  }

  Future<Comment> update(Comment comment) async {
    var request = Request<Comment>(store);
    return await request.put("/api/comments/${comment.id}", comment);
  }

  delete(Comment comment) async {
    var request = Request<Comment>(store);
    await request.delete("/api/comments/${comment.id}");
  }
}
