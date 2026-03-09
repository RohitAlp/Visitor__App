import 'dart:async';
import 'package:dio/dio.dart';
import 'package:visitorapp/networking/api_endpoints.dart';
import 'package:visitorapp/networking/dio_client.dart';

class LoginController extends ApiService {
  Future<Response?> getLogin(jsonData) async =>
      await requestPOST(path: ApiEndpoints.sendOtp, data: jsonData, token: '');

  Future<Response?> verifyOtp(jsonData) async =>
      await requestPOST(path: ApiEndpoints.verifyOtp, data: jsonData, token: '');
}
