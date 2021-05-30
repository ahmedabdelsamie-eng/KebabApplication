import 'package:flutter/material.dart';
import 'package:kabab/models/cart_item.dart';
import 'package:kabab/models/main_cart_Item.dart';

class Cart with ChangeNotifier {
  List<CartItem> _cartList = [];
  Map<String, MainCartItem> _mainCartList = {};
  List<CartItem> get cartList {
    return [..._cartList];
  }

  Map<String, MainCartItem> get mainCartList {
    return {..._mainCartList};
  }

  void addTOCart(String id, String title, String image, String market,
      String canPart, String canPrice, String quantity) {
    final index = _cartList.indexWhere((cartItem) =>
        cartItem.dadId == id && cartItem.boughtCan.containsKey(canPart));
    if (index >= 0) {
      return;
    }
    _cartList.add(
      CartItem(
        id: DateTime.now().toString(),
        title: title,
        image: image,
        market: market,
        dadId: id,
        boughtCan: {
          canPart: {'price': canPrice, 'quantity': quantity}
        },
      ),
    );
    String totalrealyprice =
        (int.parse(quantity) * int.parse(canPrice)).toString();

    if (_mainCartList.containsKey(market)) {
      if (int.parse(quantity) > 1) {
        quantity = 1.toString();
      }
      _mainCartList.update(
        market,
        (existingCartItem) => MainCartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          numberofproducts:
              (int.parse(existingCartItem.numberofproducts) + 1).toString(),
          price:
              (int.parse(existingCartItem.price) + int.parse(totalrealyprice))
                  .toString(),
        ),
      );
    } else {
      if (int.parse(quantity) > 1) {
        quantity = 1.toString();
      }

      _mainCartList.putIfAbsent(
        market,
        () => MainCartItem(
            id: DateTime.now().toString(),
            title: market,
            numberofproducts: quantity,
            price: totalrealyprice),
      );
    }
    notifyListeners();
  }

  void removeCartItem(
      String cartItemId, String market, String price, String quantity) {
    String cartItemPrice = (int.parse(quantity) * int.parse(price)).toString();

    final index = _cartList.indexWhere((element) => element.id == cartItemId);
    print(index);
    _cartList.removeAt(index);

    _mainCartList.update(market, (existingCartItem) {
      return MainCartItem(
        id: existingCartItem.id,
        title: existingCartItem.title,
        numberofproducts:
            (int.parse(existingCartItem.numberofproducts) - 1).toString(),
        price: (int.parse(existingCartItem.price) - int.parse(cartItemPrice))
            .toString(),
      );
    });

    notifyListeners();
  }
}
