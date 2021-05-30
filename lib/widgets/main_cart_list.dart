import 'package:flutter/material.dart';
import 'package:kabab/models/main_cart_Item.dart';
import 'package:kabab/widgets/main_cart_screen_item.dart';

class MainCartGridList extends StatelessWidget {
  final Map<String, MainCartItem> gettedMap;
  MainCartGridList({this.gettedMap});

  @override
  Widget build(BuildContext context) {
    gettedMap
        .removeWhere((key, value) => value.numberofproducts == 0.toString());
    return ListView.builder(
      itemCount: gettedMap.length,
      padding: EdgeInsets.all(20),
      itemBuilder: (ctx, index) => MainCArtScreenItem(
        id: gettedMap.values.toList()[index].id,
        market: gettedMap.keys.toList()[index],
        image: gettedMap.values.toList()[index].image,
        numberOfProds: gettedMap.values.toList()[index].numberofproducts,
        totalPrice: gettedMap.values.toList()[index].price,
      ),
    );
  }
}
