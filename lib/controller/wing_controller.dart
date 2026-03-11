import 'dart:async';
import 'package:dio/dio.dart';
import 'package:visitorapp/networking/api_endpoints.dart';
import 'package:visitorapp/networking/dio_client.dart';

class WingController extends ApiService {
  // Future<Response?> addWing(jsonData) async =>
  //     await requestPOST(path: ApiEndpoints.addBuilding, data: jsonData, token: '');

  Future<Response?> getWings(id) async {
    return await requestGET(
      path: ApiEndpoints.getBuildings,
      token: '',
      queryParameters: {
        "SocietyId": id
      },
    );
  }

  Future<Response?> addWing(jsonData) async => await requestPOST(
    path: ApiEndpoints.addWing,
    data: jsonData,
    token: '',
  );



}
