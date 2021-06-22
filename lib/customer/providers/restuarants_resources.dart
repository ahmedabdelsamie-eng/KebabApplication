import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kabab/customer/models/restuarantModel.dart';

class Restuarants with ChangeNotifier {
  List<RestuarantModel> _restuarants = [];
  List<RestuarantModel> get restuarants {
    return [..._restuarants];
  }

  String token;

  Restuarants(this.token, this._restuarants);

  Future<void> getrestuarantsData() async {
    final url =
        'https://kabab-b464b-default-rtdb.firebaseio.com/restuarants.json?auth=$token';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<RestuarantModel> restuarantsData = [];
      extractedData.forEach((restuarantModelId, restuarantModelData) {
        RestuarantModel d = RestuarantModel.fromJson(restuarantModelData);
        restuarantsData.add(d);
      });
      _restuarants = restuarantsData;
      notifyListeners();
    } catch (error) {
      print(error);
      // throw error;
    }
  }
}
