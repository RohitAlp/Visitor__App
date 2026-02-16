import 'dart:async';
import 'package:dio/dio.dart';
import 'package:visitorapp/networking/api_endpoints.dart';
import 'package:visitorapp/networking/dio_client.dart';

class ReceptionistController extends ApiService {

  Future<Response?> getTestDetails(String token) async {
    return await requestGET(
      path: ApiEndpoints.login,
      token: token,
    );
  }

}
