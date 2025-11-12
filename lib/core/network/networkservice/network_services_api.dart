import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:first_flutter_v1/features/auth/data/services/session_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../exceptions/app_exceptions.dart';
import 'base_api_services.dart';

class NetworkServicesApi implements BaseApiServices {
  Future<Map<String, String>> _getAuthHeaders() async {
    await SessionController().getUserFromPreference();
    final token = SessionController().userModel.accessToken;

    if (token != null && token.isNotEmpty) {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
    } else {
      return {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
    }
  }

  @override
  Future<dynamic> getApi(String url) async {
    dynamic jsonResponse;
    try {
      final headers = await _getAuthHeaders();
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 50));

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw FetchDataException('Time out try again');
    }

    return jsonResponse;
  }

  @override
  Future<dynamic> postApi(String url, var data) async {
    dynamic jsonResponse;
    if (kDebugMode) {
      print(url);
      print(data);
    }
    try {
      final headers = await _getAuthHeaders();
      final response = await http
          .post(Uri.parse(url), body: jsonEncode(data), headers: headers)
          .timeout(const Duration(seconds: 50));

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw FetchDataException('Time out try again');
    }

    return jsonResponse;
  }

  @override
  Future<dynamic> deleteApi(String url) async {
    dynamic jsonResponse;
    try {
      final headers = await _getAuthHeaders();
      final response = await http
          .delete(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 50));

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw FetchDataException('Time out try again');
    }

    return jsonResponse;
  }

  dynamic returnResponse(http.Response response) {
    if (kDebugMode) {
      print(response.statusCode);
      print(response.body);
    }
    switch (response.statusCode) {
      case 200:
      case 201:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 401:
      case 403:
        throw UnauthorisedException(jsonDecode(response.body)['message']);
      case 500:
        throw FetchDataException(
          'Error communicating with server: ${response.statusCode}',
        );
      default:
        throw FetchDataException(
          'Error occurred while communication with server: ${response.statusCode}',
        );
    }
  }
}
