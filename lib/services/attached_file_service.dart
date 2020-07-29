import 'dart:async';
import '../models/models.dart';
import 'store.dart';
import 'http.dart';

class AttachedFileService {
  final Store store;
  AttachedFileService(this.store);

  Future<AttachedFile> upload(String filePath) async {
    var request = Request<AttachedFile>(store);
    return await request.postMultipart("/api/upload/form", filePath, "upload");
  }
}
