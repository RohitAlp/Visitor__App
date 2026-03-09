import 'dart:async';
import 'package:dio/dio.dart';
import 'package:visitorapp/networking/api_endpoints.dart';
import 'package:visitorapp/networking/dio_client.dart';

class TowerController extends ApiService {
  Future<Response?> addTower(jsonData) async =>
      await requestPOST(path: "/AddBuilding", data: jsonData, token: '');


}
