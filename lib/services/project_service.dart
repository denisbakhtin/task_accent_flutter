import 'dart:async';
import '../models/models.dart';
import 'service_controller.dart';
import 'store.dart';
import 'package:meta/meta.dart';

class ProjectService extends ServiceController<Project> {
  final Store store;
  ProjectService(this.store) : super(store);

  Future<List<Project>> getList({String url}) async {
    return await super.getList(url: '/api/projects');
  }

  Future<Project> get({@required int id, String url}) async {
    return await super.get(id: id, url: '/api/projects/$id');
  }

  Future<Project> create(Project project, {String url}) async {
    return await super.create(project, url: "/api/projects");
  }

  Future<Project> update(Project project, {String url}) async {
    return await super.update(project, url: "/api/projects/${project.id}");
  }

  delete(Project project, {String url}) async {
    return await super.delete(project, url: '/api/projects/${project.id}');
  }
}
