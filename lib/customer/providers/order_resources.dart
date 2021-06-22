import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kabab/customer/models/cartModel.dart';
import 'package:kabab/customer/models/order_model.dart';
import 'package:http/http.dart' as http;

class Orders with ChangeNotifier {
  List<OrderModel> _ordersList;
  List<OrderModel> get orderList {
    return [..._ordersList];
  }

  String token;
  String userId;
  Orders(this.token, this.userId, this._ordersList);

  Future<void> addOrder(int numberOfProducts, double totalCostOfOrder,
      List<CartModel> cartProducts) async {
    final url =
        'https://kabab-b464b-default-rtdb.firebaseio.com/orders/$userId.json?auth=$token';
    try {
      final timeStamp = DateTime.now();
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'orderDateAsId': timeStamp.toIso8601String(),
            'totalCostOfOrder': totalCostOfOrder,
            'numberOfProducts': numberOfProducts,
            'products': cartProducts
                .map((cp) => {
                      'id': cp.cartId,
                      'title': cp.cartName,
                      'price': cp.cartBoughtCan.cartBoughtCanPrice,
                      'quantity': cp.cartBoughtCan.cartBoughtCanQuantity,
                      'size': cp.cartBoughtCan.cartBoughtCanTitle,
                      'itemRestuarantName': cp.cartRestuarantName,
                    })
                .toList(),
          },
        ),
      );
      _ordersList.add(
        OrderModel(
            orderDateAsId: timeStamp.toIso8601String(),
            numberOfProducts: numberOfProducts,
            totalCostOfOrder: totalCostOfOrder,
            orderDetails: cartProducts),
      );
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> getAndSetOrders() async {
    print('test1');
    final url =
        'https://kabab-b464b-default-rtdb.firebaseio.com/orders/$userId.json?auth=$token';
    try {
      final response = await http.get(Uri.parse(url));
      final List<OrderModel> loadedData = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }
      print(json.decode(response.body));
      extractedData.forEach((orderId, orderData) {
        loadedData.add(
          OrderModel(
            orderDateAsId: orderData['orderDateAsId'],
            numberOfProducts: orderData['numberOfProducts'],
            totalCostOfOrder: orderData['totalCostOfOrder'],
            orderDetails: (orderData['products'] as List<dynamic>).map((item) {
              print('test100');
              return CartModel(
                  cartId: item['id'],
                  cartName: item['title'],
                  cartRestuarantName: item['itemRestuarantName'],
                  cartBoughtCan: CartBoughtCan(
                      cartBoughtCanPrice: item['price'],
                      cartBoughtCanQuantity: item['quantity'],
                      cartBoughtCanTitle: item['size']));
            }).toList(),
          ),
        );
      });

      _ordersList = loadedData.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  List<OrderModel> get itsHour {
    return _ordersList.where((ordermodel) {
      String cartitemDate = ordermodel.orderDetails[0].cartId;
      DateTime compareDate = DateTime.parse(cartitemDate);
      return compareDate.isAfter(
        DateTime.now().subtract(
          Duration(hours: 1),
        ),
      );
    }).toList();
  }

  List<OrderModel> get oldOrders {
    return _ordersList.where((ordermodel) {
      String cartitemDate = ordermodel.orderDetails[0].cartId;
      DateTime compareDate = DateTime.parse(cartitemDate);
      return compareDate.isBefore(
        (DateTime.now().subtract(
          Duration(hours: 1),
        )),
      );
    }).toList();
  }
}
















  // Future<void> addOrderitems(
  //   List<CartModel> orderDetails,
  //   var orderModelSign,
  // ) async {
  //   try {
  //     var url =
  //         'https://kabab-b464b-default-rtdb.firebaseio.com/ordersitemslists/$userId/$orderModelSign.json?auth=$token';

  //     final response = await http.post(
  //       Uri.parse(url),
  //       body: json.encode(
  //         {
  //           'orderDetails': List<dynamic>.from(
  //             orderDetails.map(
  //               (cartItem) => {
  //                 'orderITemID': cartItem.cartId,
  //                 'orderItemName': cartItem.cartName,
  //                 'orderItemQuantity':
  //                     cartItem.cartBoughtCan.cartBoughtCanQuantity,
  //                 ' orderItemSize': cartItem.cartBoughtCan.cartBoughtCanTitle,
  //                 'orderItemRestuarantName': cartItem.cartRestuarantName,
  //                 'orderItemPrice': cartItem.cartBoughtCan.cartBoughtCanPrice,
  //               },
  //             ),
  //           ),
  //         },
  //       ),
  //     );
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  // Future<void> addOrder(int numberOfProducts, double totalCostOfOrder,
  //     List<CartModel> orderDetails) async {
  //   String orderDateTime = DateTime.now().toIso8601String();
  //   Random random = new Random();

  //   var randomorderkey = random.nextInt(100000);

  //   await addOrderitems(orderDetails, randomorderkey);

  //   try {
  //     final url =
  //         'https://kabab-b464b-default-rtdb.firebaseio.com/orders/$userId.json?auth=$token';

  //     final response = await http.post(
  //       Uri.parse(url),
  //       body: json.encode(
  //         {
  //           'orderKey': randomorderkey,
  //           'orderDateAsId': orderDateTime,
  //           'orderViewModel': {
  //             'numberOfProducts': numberOfProducts,
  //             'totalCostOfOrder': totalCostOfOrder,
  //             // 'orderDetails': List<dynamic>.from(
  //             //   orderDetails.map(
  //             //     (cartItem) => {
  //             //       'orderITemID': cartItem.cartId,
  //             //       'orderItemName': cartItem.cartName,
  //             //       'orderItemQuantity':
  //             //           cartItem.cartBoughtCan.cartBoughtCanQuantity,
  //             //       ' orderItemSize': cartItem.cartBoughtCan.cartBoughtCanTitle,
  //             //       'orderItemRestuarantName': cartItem.cartRestuarantName,
  //             //       'orderItemPrice': cartItem.cartBoughtCan.cartBoughtCanPrice,
  //             //     },
  //             //   ),
  //             // ),
  //           },
  //         },
  //       ),
  //     );
  //     _ordersList.add(
  //       OrderModel(
  //         orderDateAsId: orderDateTime,
  //         orderViewModel: OrderViewModel(
  //           numberOfProducts: numberOfProducts,
  //           totalCostOfOrder: totalCostOfOrder,
  //           orderDetails: List<OrderITem>.from(
  //             orderDetails.map(
  //               (cartITem) => OrderITem(
  //                   orderITemID: cartITem.cartId,
  //                   orderItemName: cartITem.cartName,
  //                   orderItemQuantity:
  //                       cartITem.cartBoughtCan.cartBoughtCanQuantity,
  //                   orderItemSize: cartITem.cartBoughtCan.cartBoughtCanTitle,
  //                   orderItemRestuarantName: cartITem.cartRestuarantName,
  //                   orderItemPrice: cartITem.cartPrice),
  //             ),
  //           ),
  //         ),
  //       ),
  //     );

  //     notifyListeners();
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  // Future<List<OrderITem>> getOrderitems(int orderModelSign) async {
  //   final url =
  //       'https://kabab-b464b-default-rtdb.firebaseio.com/ordersitemslists/$userId/$orderModelSign.json?auth=$token';

  //   final response = await http.get(
  //     Uri.parse(url),
  //   );
  //   final extractedDAta = json.decode(response.body) as Map<String, dynamic>;
  //   if (extractedDAta == null) {
  //     return [];
  //   }
  //   List<OrderITem> s;
  //   extractedDAta.forEach((orderIdInFire, orderItemListaskeyonMap) async {
  //     s = (orderItemListaskeyonMap['orderDetails'] as List<dynamic>).map((e) =>
  //         OrderITem(
  //             orderITemID: e['orderITemID'],
  //             orderItemName: e['orderItemName'],
  //             orderItemQuantity: e['orderItemQuantity'],
  //             orderItemSize: e[' orderItemSize'],
  //             orderItemRestuarantName: e['orderItemRestuarantName'],
  //             orderItemPrice: e['orderItemPrice']));
  //   });
  //   return s;
  // }

  // // Future<void> getAndSetOrdersItems(String a) async {
  // //   final url =
  // //       'https://kabab-b464b-default-rtdb.firebaseio.com/orders/$a/orderDetails.json?auth=$token';
  // //   try {
  // //     final response = await http.get(
  // //       Uri.parse(url),
  // //     );

  // //     final extractedDAta = json.decode(response.body) as List<dynamic>;
  // //     if (extractedDAta == null) {
  // //       return;
  // //     }
  // //     final List<OrderITem> loadedOrders = [];
  // //     extractedDAta.forEach((orderitem) {
  // //       print(orderitem.toString());
  // //     });
  // //     notifyListeners();
  // //   } catch (error) {
  // //     throw error;
  // //   }
  // // }

  // Future<void> getAndSetOrders() async {
  //   final url =
  //       'https://kabab-b464b-default-rtdb.firebaseio.com/orders/$userId.json?auth=$token';
  //   print('zzzzzzzzzzzzzzzzzzz');
  //   List<OrderITem> bb = await getOrderitems(20);
  //   print(bb.toString());

  //   try {
  //     final response = await http.get(
  //       Uri.parse(url),
  //     );

  //     final extractedDAta = json.decode(response.body) as Map<String, dynamic>;
  //     if (extractedDAta == null) {
  //       return;
  //     }
  //     final List<OrderModel> loadedOrders = [];
  //     extractedDAta.forEach(
  //       (orderIdInFire, orderModelMap) async {
  //         List<OrderITem> q = await getOrderitems(orderModelMap['orderKey']);

  //         print('vvvvvvvvvvvvvvvv');
  //         print(q.toString());
  //         print('xxxxxxxxxxxxxxxxxxx');
  //         loadedOrders.add(
  //           OrderModel(
  //             orderDateAsId: orderModelMap['orderDateAsId'],
  //             orderViewModel: OrderViewModel(
  //                 numberOfProducts: orderModelMap['orderViewModel']
  //                     ['numberOfProducts'],
  //                 totalCostOfOrder: orderModelMap['orderViewModel']
  //                     ['totalCostOfOrder'],
  //                 orderDetails: bb),
  //           ),
  //         );
  //       },
  //     );
  //     _ordersList = loadedOrders;
  //     print('rrrrrrrrrrrrrrrrrr1');

  //     print(_ordersList[0].toString());
  //     print('rrrrrrrrrrrrrrrrrrrrrrr2');
  //     notifyListeners();
  //   } catch (error) {
  //     print(error);
  //     throw error;
  //   }
  // }

  