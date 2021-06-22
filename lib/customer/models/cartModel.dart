import 'package:flutter/cupertino.dart';

class CartModel {
  final String cartId;
  final String cartName;
  final String cartImage;
  final int cartPrice;
  final String cartDadId;
  final String cartRestuarantName;
  final CartBoughtCan cartBoughtCan;
  CartModel(
      {@required this.cartId,
      @required this.cartName,
      this.cartImage,
      this.cartPrice,
      this.cartDadId,
      @required this.cartRestuarantName,
      this.cartBoughtCan});

  // factory CartModel.fromJson(Map<String, dynamic> json) {
  //   return CartModel(
  //     cartId: json["cartId"],
  //     cartName: json["cartName"],
  //     cartImage: json["cartImage"],
  //     cartPrice: json["cartPrice"],
  //     cartDadId: json["cartDadId"],
  //     cartRestuarantName: json["cartRestuarantName"],
  //     cartBoughtCan: CartBoughtCan.fromJson(
  //       json['cartBoughtCan'],
  //     ),
  //   );
  // }
  // Map<String, dynamic> toJson() => {
  //       "cartId": cartId,
  //       "cartName": cartName,
  //       "cartImage": cartImage,
  //       "cartPrice": cartPrice,
  //       "cartDadId": cartDadId,
  //       "cartRestuarantName": cartRestuarantName,
  // "cartBoughtCan": cartBoughtCan.toJson(),
  // };
}

class CartBoughtCan {
  final String cartBoughtCanTitle;
  final int cartBoughtCanQuantity;
  final int cartBoughtCanPrice;

  CartBoughtCan(
      {@required this.cartBoughtCanTitle,
      @required this.cartBoughtCanQuantity,
      @required this.cartBoughtCanPrice});

  // factory CartBoughtCan.fromJson(Map<String, dynamic> json) {
  //   return CartBoughtCan(
  //     cartBoughtCanTitle: json["cartBoughtCanTitle"],
  //     cartBoughtCanQuantity: json["cartBoughtCanQuantity"],
  //     cartBoughtCanPrice: json["cartBoughtCanPrice"],
  //   );
  // }
  // Map<String, dynamic> toJson() => {
  //       "cartBoughtCanTitle": cartBoughtCanTitle,
  //       "cartBoughtCanQuantity": cartBoughtCanQuantity,
  //       "cartBoughtCanPrice": cartBoughtCanPrice,
  //     };
}
