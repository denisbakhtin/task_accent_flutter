import '../models/models.dart';
import 'services.dart';
import 'store.dart';

class ReportService {
  final Store store;
  ReportService(this.store);

  Future<List<TaskLog>> getSpent() async {
    var request = Request<TaskLog>(store);
    return await request.getList('/api/reports/spent');
  }
}
