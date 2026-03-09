import 'dart:async';
import 'package:dio/dio.dart';
import 'package:visitorapp/networking/api_endpoints.dart';
import 'package:visitorapp/networking/dio_client.dart';
import 'package:visitorapp/model/getSocietyResponse.dart';

class SocietyController extends ApiService {

  Future<Response?> getSociety(Map<String, dynamic>? query) async {
    return await requestGET(
      path: ApiEndpoints.getSociety,
      queryParameters: query,
      token: '',
    );
  }

  Future<Response?> deleteSociety(Map<String, dynamic>? query) async {
    return await requestDELETE(
      path: ApiEndpoints.deleteSociety,
      queryParameters: query,
      token: '',
    );
  }

}