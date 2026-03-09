import 'dart:async';
import 'package:dio/dio.dart';
import 'package:visitorapp/networking/api_endpoints.dart';
import 'package:visitorapp/networking/dio_client.dart';

class TowerController extends ApiService {
  Future<Response?> addTower(jsonData) async =>
      await requestPOST(path: ApiEndpoints.addBuilding, data: jsonData, token: '');

  Future<Response?> getTowers(id) async {
    return await requestGET(
      path: ApiEndpoints.getBuildings,
      token: '',
      queryParameters: {
        "SocietyId": id
      },
    );
  }

  Future<Response?> deleteTower(Map<String, dynamic>? query) async {
    return await requestDELETE(
      path: ApiEndpoints.deleteTower,
      queryParameters: query,
      token: '',
    );
  }



}
