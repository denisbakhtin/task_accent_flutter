import 'dart:async';
import '../models/models.dart';
import 'service_controller.dart';
import 'store.dart';
import 'package:meta/meta.dart';

class CategoryService extends ServiceController<Category> {
  final Store store;
  CategoryService(this.store) : super(store);

  Future<List<Category>> getList({String url}) async {
    return await super.getList(url: '/api/categories');
  }

  Future<Category> get({@required int id, String url}) async {
    return await super.get(id: id, url: '/api/categories/$id');
  }

  Future<Category> create(Category category, {String url}) async {
    return await super.create(category, url: "/api/categories");
  }

  Future<Category> update(Category category, {String url}) async {
    return await super.update(category, url: "/api/categories/${category.id}");
  }

  delete(Category category, {String url}) async {
    return await super.delete(category, url: '/api/categories/${category.id}');
  }
}
