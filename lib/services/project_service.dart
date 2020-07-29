import 'dart:async';
import '../models/models.dart';
import 'services.dart';
import 'store.dart';

class ProjectService {
  final Store store;
  ProjectService(this.store);

  Future<List<Project>> getList() async {
    var request = Request<Project>(store);
    return await request.getList('/api/projects');
  }

  Future<Project> get(int id) async {
    var request = Request<Project>(store);
    return await request.get('/api/projects/$id');
  }

  Future<Project> create(Project project) async {
    var request = Request<Project>(store);
    return await request.post('/api/projects', project);
  }

  Future<Project> update(Project project) async {
    var request = Request<Project>(store);
    return await request.put("/api/projects/${project.id}", project);
  }

  delete(Project project) async {
    var request = Request<Project>(store);
    await request.delete("/api/projects/${project.id}");
  }

  Future<ProjectsSummary> getSummary() async {
    var request = Request<ProjectsSummary>(store);
    return await request.get('/api/projects_summary');
  }
}
