import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../app-config.dart';

class CarRentAPIService{


  //============== car rent list ==============//
  Future<http.Response> getCarRentList()async{
    return await http.get(Uri.parse(AppConfig.showAllCarRentService),
    );
  }

  //============== Sing car rent list ==============//
  Future<http.Response> getSingleCarRent(String id)async{
    return await http.get(Uri.parse(AppConfig.singleCarRent+"/$id"),
    );
  }

  //============== Sing car rent list ==============//
  Future<http.Response> sendCarRentRequest(Map<String, dynamic> body)async{
    SharedPreferences localDatabase = await SharedPreferences.getInstance();
    var token = localDatabase.getString("token");
    return await http.post(Uri.parse(AppConfig.sendCarRentRequest),
      body: body,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }

  //============== Sing car rent list ==============//
  Future<http.Response> getCarRentRequestList()async{
    SharedPreferences localDatabase = await SharedPreferences.getInstance();
    var token = localDatabase.getString("token");
    return await http.get(Uri.parse(AppConfig.carRentRequestList),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }

  //============== Sing car rent list ==============//
  Future<http.Response> getPendingRentList()async{
    SharedPreferences localDatabase = await SharedPreferences.getInstance();
    var token = localDatabase.getString("token");
    return await http.get(Uri.parse(AppConfig.pendingRentList),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }

  //============== Sing car rent list ==============//
  Future<http.Response> getAcceptRentList()async{
    SharedPreferences localDatabase = await SharedPreferences.getInstance();
    var token = localDatabase.getString("token");
    return await http.get(Uri.parse(AppConfig.acceptRentList),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }

  //============== Sing car rent list ==============//
  Future<http.Response> getCancelRentList()async{
    SharedPreferences localDatabase = await SharedPreferences.getInstance();
    var token = localDatabase.getString("token");
    return await http.get(Uri.parse(AppConfig.cancelRentList),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }

  //============== vendor status update rent request ==============//
  Future<http.Response> updateRequestStatus(id, status)async{
    SharedPreferences localDatabase = await SharedPreferences.getInstance();
    var token = localDatabase.getString("token");
    return await http.post(Uri.parse(AppConfig.vendorRequestUpdate),
      body: {
        "id" : id,
        "status" : status,
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }
}