import 'dart:async';
import '../models/models.dart';
import 'service_controller.dart';
import 'services.dart';
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

  Future<CategoriesSummary> getSummary() async {
    var req = new Request.get("/api/categories_summary");
    var response = await req.executeUserRequest(store);

    switch (response.statusCode) {
      case 200:
        {
          var summary = new CategoriesSummary.fromJson(response.body);
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
