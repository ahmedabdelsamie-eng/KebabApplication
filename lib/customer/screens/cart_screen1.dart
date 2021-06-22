import 'package:flutter/material.dart';

class CartScreen1 extends StatelessWidget {
  static const routeName = '/cart-screen1';

  @override
  Widget build(BuildContext context) {
    // final cartDAta = Provider.of<Cart>(context).mainCartList;

    // return Scaffold(
    //   backgroundColor: Colors.white10,
    //   appBar: AppBar(
    //     title: Container(
    //       child: Text(
    //         'سلة التسوق',
    //         style: TextStyle(color: Colors.teal),
    //       ),
    //       padding: EdgeInsets.symmetric(
    //         horizontal: 20,
    //       ),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(15),
    //         color: Colors.white,
    //       ),
    //     ),
    //     centerTitle: true,
    //   ),
    //   body: MainCartGridList(
    //     gettedMap: cartDAta,
    //   ),
    // );
  }
}
