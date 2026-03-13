import 'dart:async';
import 'package:dio/dio.dart';
import 'package:visitorapp/networking/api_endpoints.dart';
import 'package:visitorapp/networking/dio_client.dart';

class FlatController extends ApiService {
  Future<Response?> addFlat(jsonData) async =>
      await requestPOST(path: ApiEndpoints.addFlat, data: jsonData, token: '');
}
