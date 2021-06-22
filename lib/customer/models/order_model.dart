import 'package:flutter/material.dart';
import 'package:kabab/customer/models/cartModel.dart';

class OrderModel {
  OrderModel({
    this.orderDateAsId,
    @required this.numberOfProducts,
    @required this.totalCostOfOrder,
    this.orderDetails,
  });
  var orderDateAsId;
  final int numberOfProducts;
  final double totalCostOfOrder;
  final List<CartModel> orderDetails;

  // factory OrderModel.fromJson(Map<String, dynamic> json) {
  //   return OrderModel(
  //     orderDateAsId: json['orderDateAsId'],
  //     orderViewModel: OrderViewModel.fromJson(json['restuarantViewModel']),
  //   );
  // }
  // Map<String, dynamic> toJson() => {
  //       'orderDateAsId': orderDateAsId,
  //       'restuarantViewModel': orderViewModel.toJson(),
  //     };
}

class OrderViewModel {
  OrderViewModel({
    @required this.numberOfProducts,
    @required this.totalCostOfOrder,
    @required this.orderDetails,
  });
  final int numberOfProducts;
  final double totalCostOfOrder;
  final List<OrderITem> orderDetails;

  factory OrderViewModel.fromJson(Map<String, dynamic> json) {
    return OrderViewModel(
      numberOfProducts: json['numberOfProducts'],
      totalCostOfOrder: json['totalCostOfOrder'],
      orderDetails: List<OrderITem>.from(
          json['orderDetails'].map((x) => OrderITem.fromJson(x))),
    );
  }
  Map<String, dynamic> toJson() => {
        'numberOfProducts': numberOfProducts,
        'totalCostOfOrder': totalCostOfOrder,
        'orderDetails': List<dynamic>.from(orderDetails.map((e) => e.toJson())),
      };
}

class OrderITem {
  final String orderITemID;
  final String orderItemName;
  final int orderItemQuantity;
  final String orderItemSize;
  final String orderItemRestuarantName;
  final int orderItemPrice;
  OrderITem(
      {@required this.orderITemID,
      @required this.orderItemName,
      @required this.orderItemQuantity,
      @required this.orderItemSize,
      @required this.orderItemRestuarantName,
      @required this.orderItemPrice});

  factory OrderITem.fromJson(Map<String, dynamic> json) {
    print('problem');
    return OrderITem(
        orderITemID: json['orderITemID'],
        orderItemName: json['orderItemName'],
        orderItemQuantity: json['orderItemQuantity'],
        orderItemSize: json['orderItemSize'],
        orderItemRestuarantName: json['orderItemRestuarantName'],
        orderItemPrice: json['orderItemPrice']);
  }
  Map<String, dynamic> toJson() => {
        'orderITemID': orderITemID,
        'orderItemName': orderItemName,
        'orderItemQuantity': orderItemQuantity,
        ' orderItemSize': orderItemSize,
        'orderItemRestuarantName': orderItemRestuarantName,
        'orderItemPrice': orderItemPrice,
      };
}
