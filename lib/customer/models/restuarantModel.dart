import 'dart:convert';

import 'package:flutter/cupertino.dart';

RestuarantModel productModelFromJson(String str) =>
    RestuarantModel.fromJson(json.decode(str));

String productModelToJson(RestuarantModel data) => json.encode(data.toJson());

class RestuarantModel {
  RestuarantModel({
    this.key,
    this.restuarantViewModel,
  });

  String key;
  RestuarantViewModel restuarantViewModel;

  factory RestuarantModel.fromJson(Map<String, dynamic> json) {
    return RestuarantModel(
      key: json["key"],
      restuarantViewModel:
          RestuarantViewModel.fromJson(json["RestuarantViewModel"]),
    );
  }
  Map<String, dynamic> toJson() => {
        "key": key,
        "RestuarantViewModel": restuarantViewModel.toJson(),
      };
}

class RestuarantViewModel {
  RestuarantViewModel({
    this.restuarantName,
    this.restuarantImage,
    this.longitude,
    this.latitude,
    this.deptData,
  });

  String restuarantName;

  String restuarantImage;

  double longitude;

  double latitude;
  List<RestuarantDepartent> deptData;

  factory RestuarantViewModel.fromJson(Map<String, dynamic> json) {
    return RestuarantViewModel(
      restuarantName: json["restuarantName"],
      restuarantImage: json["restuarantImage"],
      longitude: json['longitude'],
      latitude: json['latitude'],
      deptData: List<RestuarantDepartent>.from(
          json['deptData'].map((x) => RestuarantDepartent.fromJson(x))),
    );
  }
  Map<String, dynamic> toJson() => {
        "restuarantName": restuarantName,
        "restuarantImage": restuarantImage,
        "longitude": longitude,
        "latitude": latitude,
        "deptData": List<dynamic>.from(deptData.map((x) => x.toJson())),
      };
}

class RestuarantDepartent {
  RestuarantDepartent({
    this.restuarantDeptName,
    this.productData,
  });

  String restuarantDeptName;
  List<ProductDatum> productData;

  factory RestuarantDepartent.fromJson(Map<String, dynamic> json) {
    // List<Map<String, dynamic>> b = json['productData'].values.toList();

    return RestuarantDepartent(
      restuarantDeptName: json["restuarantDeptName"],
      productData: List<ProductDatum>.from(
          json['productData'].map((x) => ProductDatum.fromJson(x))),
    );
  }
  Map<String, dynamic> toJson() => {
        "restuarantDeptName": restuarantDeptName,
        "productData": List<dynamic>.from(productData.map((x) => x.toJson())),
      };
}

class ProductDatum {
  ProductDatum(
      {@required this.productId,
      @required this.name,
      @required this.image,
      @required this.price,
      @required this.restuarantName,
      @required this.cansPrices});
  String image;
  int price;
  String restuarantName;
  CansPrices cansPrices;
  String productId;
  String name;

  factory ProductDatum.fromJson(Map<String, dynamic> json) {
    return ProductDatum(
      productId: json['productId'],
      name: json["name"],
      image: json['image'],
      price: json['price'],
      restuarantName: json['restuarantName'],
      cansPrices: CansPrices.fromJson(json['cansPrices']),
    );
  }

  Map<String, dynamic> toJson() => {
        'productId': productId,
        "name": name,
        "image": image,
        "price": price,
        "restuarantName": restuarantName,
        "cansprices": cansPrices.toJson(),
      };
}

class CansPrices {
  CansPrices({
    @required this.kilo,
    @required this.kilo3,
    @required this.kilo5,
  });
  int kilo;
  int kilo3;
  int kilo5;

  factory CansPrices.fromJson(Map<String, dynamic> json) {
    return CansPrices(
      kilo: json['kilo'],
      kilo3: json['3kilo'],
      kilo5: json['5kilo'],
    );
  }

  Map<String, dynamic> toJson() => {
        "kilo": kilo,
        "3kilo": kilo3,
        "5kilo": kilo5,
      };
}
