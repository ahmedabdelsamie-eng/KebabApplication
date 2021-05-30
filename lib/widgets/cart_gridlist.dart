import 'package:flutter/material.dart';
import 'package:kabab/models/cart_item.dart';

import 'cart_screen_item.dart';

class CartGridList extends StatelessWidget {
  final List<CartItem> gettedList;
  CartGridList({this.gettedList});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: gettedList
          .map(
            (cartItem) => CArtScreenItem(
              id: cartItem.id,
              title: cartItem.title,
              image: cartItem.image,
              market: cartItem.market,
              boughtCan: cartItem.boughtCan,
            ),
          )
          .toList(),
    );
  }
}
