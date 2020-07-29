import 'dart:async';
import '../models/models.dart';
import 'services.dart';
import 'store.dart';

class CategoryService {
  final Store store;
  CategoryService(this.store);

  Future<List<Category>> getList() async {
    var request = Request<Category>(store);
    return await request.getList('/api/categories');
  }

  Future<Category> get(int id) async {
    var request = Request<Category>(store);
    return await request.get('/api/categories/$id');
  }

  Future<Category> create(Category category) async {
    var request = Request<Category>(store);
    return await request.post('/api/categories', category);
  }

  Future<Category> update(Category category) async {
    var request = Request<Category>(store);
    return await request.put("/api/categories/${category.id}", category);
  }

  delete(Category category) async {
    var request = Request<Category>(store);
    await request.delete("/api/categories/${category.id}");
  }

  Future<CategoriesSummary> getSummary() async {
    var request = Request<CategoriesSummary>(store);
    return await request.get('/api/categories_summary');
  }
}
