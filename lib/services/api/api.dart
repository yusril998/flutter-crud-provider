import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

class Api {
  String baseUrl = "https://api.tes-flutter.griyadepo.com/api/";
  Options option = Options(
    headers: {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    },
    receiveDataWhenStatusError: true,
  );
  final Duration _timeout = const Duration(seconds: 10);

  Future<Response?> get(String url, {bool withBaseUrl = true}) async {
    var urlRequest = withBaseUrl ? baseUrl + url : url;
    Response json = await Dio()
        .get(urlRequest, options: option)
        .timeout(_timeout, onTimeout: () {
      throw TimeoutException(
          'Aplikasi terlalu lama mengambil data. Silakan coba lagi');
    });

    return json;
  }

  Future<Response?> post(
    String url,
    dynamic body, {
    ModeParamRequest mode = ModeParamRequest.Json,
    bool withBaseUrl = true,
  }) async {
    var urlRequest = withBaseUrl ? baseUrl + url : url;
    var formData;
    if (mode == ModeParamRequest.FormData) {
      formData = FormData.fromMap(body);
    } else {
      formData = jsonEncode(body);
    }

    Response json = await Dio()
        .post(urlRequest, data: formData, options: option)
        .timeout(_timeout, onTimeout: () {
      throw TimeoutException(
          'Aplikasi terlalu lama mengambil data. Silakan coba lagi');
    });
    return json;
  }

  Future<Response?> put(
    String url,
    Map<String, dynamic> body, {
    bool withBaseUrl = true,
  }) async {
    var urlRequest = withBaseUrl ? baseUrl + url : url;
    var formData = body;

    Response json = await Dio()
        .put(urlRequest, data: formData, options: option)
        .timeout(_timeout, onTimeout: () {
      throw TimeoutException(
          'Aplikasi terlalu lama mengambil data. Silakan coba lagi');
    });
    return json;
  }

  Future<Response?> delete(
    String url,
    Map<String, dynamic> body, {
    bool withBaseUrl = true,
  }) async {
    var urlRequest = withBaseUrl ? baseUrl + url : url;
    FormData formData = FormData.fromMap(body);
    Response json = await Dio()
        .delete(urlRequest, data: formData, options: option)
        .timeout(_timeout, onTimeout: () {
      throw TimeoutException(
          'Aplikasi terlalu lama mengambil data. Silakan coba lagi');
    });
    return json;
  }
}

enum ModeParamRequest { FormData, Json }
