import 'dart:async';
import '../models/models.dart';
import 'service_controller.dart';
import 'store.dart';

class ReportService extends ServiceController<TaskLog> {
  final Store store;
  ReportService(this.store) : super(store);

  Future<List<TaskLog>> getSpent({String url}) async {
    return await super.getList(url: '/api/reports/spent');
  }
}
