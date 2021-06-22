import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kabab/customer/providers/cart_resources.dart';
import 'package:provider/provider.dart';
import 'cart_screen_item.dart';

class CartGridList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var listy = Provider.of<Cart>(context).cartList;
    return AnimationLimiter(
      child: ListView.builder(
          itemCount: listy.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 700),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: CArtScreenItem(
                    id: listy[index].cartId,
                    title: listy[index].cartName,
                    image: listy[index].cartImage,
                    restuarantName: listy[index].cartRestuarantName,
                    boughtCan: listy[index].cartBoughtCan,
                  ),
                ),
              ),
            );
          }),
    );

    // return ListView(
    //   padding: EdgeInsets.all(20),
    //   children: Provider.of<Cart>(context)
    //       .cartList
    //       .map(
    //         (cartModel) => CArtScreenItem(
    //           id: cartModel.cartId,
    //           title: cartModel.cartName,
    //           image: cartModel.cartImage,
    //           restuarantName: cartModel.cartRestuarantName,
    //           boughtCan: cartModel.cartBoughtCan,
    //         ),
    //       )
    //       .toList(),
    // );
  }
}
