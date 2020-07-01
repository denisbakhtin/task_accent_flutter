import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'store.dart';
import 'dart:io';

const contentTypeHeader = "Content-Type";
const authorizationHeader = "Authorization";
const jsonContentType = "application/json";
const baseURL = "http://192.168.1.32:8181";
const tokenKey = "auth_token";

class Request {
  Request.get(this.path) {
    method = "GET";
  }
  Request.post(this.path, this.body, {String contentType}) {
    this.contentType = contentType ?? jsonContentType;
    method = "POST";
  }
  Request.postMultipart(this.path, this.filePath, this.fileField,
      {String contentType}) {
    this.contentType = contentType ?? jsonContentType;
    method = "POST";
  }
  Request.put(this.path, this.body, {String contentType}) {
    this.contentType = contentType ?? jsonContentType;
    method = "PUT";
  }
  Request.delete(this.path) {
    this.contentType = jsonContentType;
    method = "DELETE";
  }

  String method;
  String path;
  String filePath; //full file path for upload
  String fileField; //file field name for upload
  dynamic body;
  String get contentType => _contentType;
  set contentType(String t) {
    _contentType = t;
    if (_contentType != null) {
      headers[contentTypeHeader] = _contentType;
    }
  }

  String _contentType;
  Map<String, String> headers = {};

  Future<Response> executeUserRequest(Store store) async {
    //NOTE: ensure async token is loaded in Store constructor
    var token = store.token;

    headers[authorizationHeader] = _authHeaderValue(token);
    var response = await executeRequest(store);

    if (response.statusCode == 401) {
      // Refresh the token, try again
    }

    return response;
  }

  Future<Response> executeUserMultipartRequest(Store store) async {
    //NOTE: ensure async token is loaded in Store constructor
    var token = store.token;

    headers[authorizationHeader] = _authHeaderValue(token);
    var response = await executeMultipartRequest(store);

    if (response.statusCode == 401) {
      // Refresh the token, try again
    }

    return response;
  }

  Future<Response> executeRequest(Store store) async {
    try {
      if (body != null) {
        body = json.encode(body);
      }
      if (method == "GET")
        return new Response.fromHTTPResponse(
            await http.get(baseURL + path, headers: headers));
      else if (method == "POST")
        return new Response.fromHTTPResponse(
            await http.post(baseURL + path, headers: headers, body: body));
      else if (method == "PUT")
        return new Response.fromHTTPResponse(
            await http.put(baseURL + path, headers: headers, body: body));
      else if (method == "DELETE")
        return new Response.fromHTTPResponse(
            await http.delete(baseURL + path, headers: headers));
      else
        throw 'Unsupported HTTP method';
    } catch (e) {
      return new Response.failed(e);
    }
  }

  Future<Response> executeMultipartRequest(Store store) async {
    try {
      if (body != null) {
        body = json.encode(body);
      }

      var request = http.MultipartRequest(method, Uri.parse(baseURL + path));
      request.headers[authorizationHeader] = headers[authorizationHeader];
      var file = File(filePath);
      request.files.add(http.MultipartFile(
          fileField, file.readAsBytes().asStream(), file.lengthSync(),
          filename: filePath.split("/").last));
      return new Response.fromHTTPResponse(
          await http.Response.fromStream(await request.send()));
    } catch (e) {
      return new Response.failed(e);
    }
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
  }

  Response.failed(this.error);

  int statusCode;
  dynamic body;
  Object error;
}

class UnauthenticatedException implements Exception {}

class APIError {
  APIError(this.reason) {
    reason ??= "Unknown failure";
  }

  String reason;

  @override
  String toString() => reason;
}
