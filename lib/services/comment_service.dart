import 'dart:async';
import '../models/models.dart';
import 'service_controller.dart';
import 'store.dart';
import 'package:meta/meta.dart';

class CommentService extends ServiceController<Comment> {
  final Store store;
  CommentService(this.store) : super(store);

  Future<List<Comment>> getList({String url}) async {
    return await super.getList(url: '/api/comments');
  }

  Future<Comment> get({@required int id, String url}) async {
    return await super.get(id: id, url: '/api/comments/$id');
  }

  Future<Comment> create(Comment comment, {String url}) async {
    return await super.create(comment, url: "/api/comments");
  }

  Future<Comment> update(Comment comment, {String url}) async {
    return await super.update(comment, url: "/api/comments/${comment.id}");
  }

  delete(Comment comment, {String url}) async {
    return await super.delete(comment, url: '/api/comments/${comment.id}');
  }
}
