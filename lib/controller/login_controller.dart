import 'dart:async';
import 'package:dio/dio.dart';
import 'package:visitorapp/networking/api_endpoints.dart';
import 'package:visitorapp/networking/dio_client.dart';

class LoginController extends ApiService {

  Future<Response?> login(String token) async {
    return await requestPOST(
      path: ApiEndpoints.login,
      token: token,
      data: '',
    );
  }

}
