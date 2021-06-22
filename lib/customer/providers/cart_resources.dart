import 'package:flutter/material.dart';
import 'package:kabab/customer/models/cartModel.dart';

class Cart with ChangeNotifier {
  List<CartModel> _cartList = [];
  List<CartModel> get cartList {
    return [..._cartList];
  }

  void addTOCart(
      String dadId,
      String name,
      String image,
      int price,
      String restuarantName,
      String canboughtTitle,
      int canBoughtPrice,
      int canBoughtQuantity) async {
    final index = _cartList.indexWhere((cartItem) =>
        cartItem.cartDadId == dadId &&
        cartItem.cartBoughtCan.cartBoughtCanTitle == canboughtTitle);
    if (index >= 0) {
      return;
    }

    _cartList.add(
      CartModel(
        cartId: DateTime.now().toString(),
        cartName: name,
        cartImage: image,
        cartRestuarantName: restuarantName,
        cartDadId: dadId,
        cartPrice: price,
        cartBoughtCan: CartBoughtCan(
            cartBoughtCanTitle: canboughtTitle,
            cartBoughtCanPrice: canBoughtPrice,
            cartBoughtCanQuantity: canBoughtQuantity),
      ),
    );

    notifyListeners();
  }

  void removeCartItem(String cartItemId) {
    final index =
        _cartList.indexWhere((element) => element.cartId == cartItemId);

    _cartList.removeAt(index);

    notifyListeners();
  }

  double getTotal() {
    if (_cartList.length == 0) {
      print('hihhhhhhhhhhhhhhhhhhhh');
      return 0;
    }
    double totaly = 0;

    _cartList.forEach((element) {
      totaly += element.cartBoughtCan.cartBoughtCanPrice *
          element.cartBoughtCan.cartBoughtCanQuantity;
    });
    return totaly;
  }

  void clear() {
    _cartList = [];
    notifyListeners();
  }
}

















    // String totalrealyprice =
    //     (int.parse(quantity) * int.parse(canPrice)).toString();

    // if (_mainCartList.containsKey(market)) {
    //   if (int.parse(quantity) > 1) {
    //     quantity = 1.toString();
    //   }
    //   _mainCartList.update(
    //     market,
    //     (existingCartItem) => MainCartItem(
    //       id: existingCartItem.id,
    //       title: existingCartItem.title,
    //       numberofproducts:
    //           (int.parse(existingCartItem.numberofproducts) + 1).toString(),
    //       price:
    //           (int.parse(existingCartItem.price) + int.parse(totalrealyprice))
    //               .toString(),
    //     ),
    //   );
    // } else {
    //   if (int.parse(quantity) > 1) {
    //     quantity = 1.toString();
    //   }

    //   _mainCartList.putIfAbsent(
    //     market,
    //     () => MainCartItem(
    //         id: DateTime.now().toString(),
    //         title: market,
    //         numberofproducts: quantity,
    //         price: totalrealyprice),
    //   );
    // }







    
  // void removeCartItem(
  //     String cartItemId, String market, String price, String quantity) {
  //   String cartItemPrice = (int.parse(quantity) * int.parse(price)).toString();

  //   final index = _cartList.indexWhere((element) => element.id == cartItemId);
  //   print(index);
  //   _cartList.removeAt(index);

  //   _mainCartList.update(market, (existingCartItem) {
  //     return MainCartItem(
  //       id: existingCartItem.id,
  //       title: existingCartItem.title,
  //       numberofproducts:
  //           (int.parse(existingCartItem.numberofproducts) - 1).toString(),
  //       price: (int.parse(existingCartItem.price) - int.parse(cartItemPrice))
  //           .toString(),
  //     );
  //   });