import 'dart:async';
import '../models/models.dart';
import 'service_controller.dart';
import 'store.dart';
import 'http.dart';

class AttachedFileService extends ServiceController<AttachedFile> {
  final Store store;
  AttachedFileService(this.store) : super(store);

  //it does not manage the underlying list, so no point in watching it, just use the returned value instead
  Future<AttachedFile> upload(String filePath, {String url}) async {
    var req = Request.postMultipart("/api/upload/form", filePath, "upload");
    var response = await req.executeUserMultipartRequest(store);

    if (response.error != null) {
      addListError(response.error);
      return null;
    }

    switch (response.statusCode) {
      case 200:
        {
          return AttachedFile.fromJson(response.body);
        }
        break;

      default:
        addListError(APIError(response.body["error"] ?? response.body));
    }
    return null;
  }
}
