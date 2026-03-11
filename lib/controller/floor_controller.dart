import 'dart:async';
import 'package:dio/dio.dart';
import 'package:visitorapp/networking/api_endpoints.dart';
import 'package:visitorapp/networking/dio_client.dart';

class FloorController extends ApiService {
  Future<Response?> addFloor(jsonData) async =>
      await requestPOST(
        path: ApiEndpoints.addFloor,
        data: jsonData,
        token: '',
      );
}