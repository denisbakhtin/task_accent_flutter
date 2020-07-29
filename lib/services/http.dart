import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:task_accent/models/models.dart';
import 'dart:convert';
import 'store.dart';
import 'dart:io';

const contentTypeHeader = "Content-Type";
const authorizationHeader = "Authorization";
const jsonContentType = "application/json";
const baseURL = "http://192.168.1.32:8181";
enum Method { get, post, put, delete }

//T is a base class, for requesting List<T> use Request<T>.getList(..) instead
class Request<T> {
  final Store store;
  Request(this.store);

  Future<T> get(String path) async {
    var response = await _executeRequest(Method.get, path);
    return _fromJson(response.body);
  }

  Future<List<T>> getList(String path) async {
    var response = await _executeRequest(Method.get, path);
    return (response.body as List<dynamic>).map((o) => _fromJson(o)).toList();
  }

  Future<T> post(String path, dynamic body) async {
    var response = await _executeRequest(Method.post, path, body: body);
    return _fromJson(response.body);
  }

  Future<T> put(String path, dynamic body) async {
    var response = await _executeRequest(Method.put, path, body: body);
    return _fromJson(response.body);
  }

  Future delete(String path) async {
    await _executeRequest(Method.delete, path);
  }

  //String filePath - full file path for upload
  //String fileField - file field name for upload
  Future<T> postMultipart(
      String path, String filePath, String fileField) async {
    var response = await _executeMultipartRequest(path, filePath, fileField);
    return _fromJson(response.body);
  }

  Future<Response> _executeRequest(Method method, String path,
      {dynamic body}) async {
    Map<String, String> headers = {};
    //NOTE: ensure token is async loaded by Store constructor
    var token = store.token;
    if (token != null) headers[authorizationHeader] = _authHeaderValue(token);
    headers[contentTypeHeader] = jsonContentType;

    if (body != null) {
      body = json.encode(_toJson(body));
    }

    switch (method) {
      case Method.get:
        return new Response.fromHTTPResponse(
            await http.get(baseURL + path, headers: headers));
      case Method.post:
        return new Response.fromHTTPResponse(
            await http.post(baseURL + path, headers: headers, body: body));
      case Method.put:
        return new Response.fromHTTPResponse(
            await http.put(baseURL + path, headers: headers, body: body));
      case Method.delete:
        return new Response.fromHTTPResponse(
            await http.delete(baseURL + path, headers: headers));
      default:
        throw 'Unsupported HTTP method';
    }
  }

  Future<Response> _executeMultipartRequest(
      String path, String filePath, String fileField) async {
    var request = http.MultipartRequest('POST', Uri.parse(baseURL + path));
    //NOTE: ensure token is async loaded by Store constructor
    var token = store.token;
    if (token != null)
      request.headers[authorizationHeader] = _authHeaderValue(token);
    var file = File(filePath);
    request.files.add(http.MultipartFile(
        fileField, file.readAsBytes().asStream(), file.lengthSync(),
        filename: filePath.split("/").last));
    return new Response.fromHTTPResponse(
        await http.Response.fromStream(await request.send()));
  }

  T _fromJson(Map<String, dynamic> m) {
    //seems there is no better way to check the base type without mirrors...
    if (T == User) return (User.fromJson(m) as T);
    if (T == Project) return (Project.fromJson(m) as T);
    if (T == Task) return (Task.fromJson(m) as T);
    if (T == Category) return (Category.fromJson(m) as T);
    if (T == Session) return (Session.fromJson(m) as T);
    if (T == TaskLog) return (TaskLog.fromJson(m) as T);
    if (T == Comment) return (Comment.fromJson(m) as T);
    if (T == CategoriesSummary) return (CategoriesSummary.fromJson(m) as T);
    if (T == ProjectsSummary) return (ProjectsSummary.fromJson(m) as T);
    if (T == TasksSummary) return (TasksSummary.fromJson(m) as T);
    if (T == SessionsSummary) return (SessionsSummary.fromJson(m) as T);
    if (T == AuthorizationToken) return (AuthorizationToken.fromJson(m) as T);
    //add other classes accordingly, otherwise meet this error :P

    throw UnsupportedError("fromJson on $T");
  }

  Map<String, dynamic> _toJson(dynamic element) {
    if (element is User) return element.toJson();
    if (element is Project) return element.toJson();
    if (element is Task) return element.toJson();
    if (element is Category) return element.toJson();
    if (element is Session) return element.toJson();
    if (element is TaskLog) return element.toJson();
    if (element is Comment) return element.toJson();
    if (element is CategoriesSummary) return element.toJson();
    if (element is ProjectsSummary) return element.toJson();
    if (element is TasksSummary) return element.toJson();
    if (element is SessionsSummary) return element.toJson();
    if (element is LoginModel) return element.toJson();
    //add other classes accordingly, otherwise meet this error :P

    throw UnsupportedError("toJson on ${element.runtimeType}");
  }

  String _authHeaderValue(String token) => "Bearer $token";
}

class Response {
  Response.fromHTTPResponse(http.Response response) {
    statusCode = response.statusCode;

    var contentType = response.headers["content-type"];
    if (contentType?.contains(jsonContentType) ?? false) {
      body = json.decode(response.body);
    }

    //if == 401, refresh token?
    if (statusCode >= 300)
      throw (body is Map<String, dynamic>) ? body["error"] : body;
  }

  int statusCode;
  dynamic body;
}

class UnauthenticatedException implements Exception {}
