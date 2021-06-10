import 'package:flutter/material.dart';
import 'package:kabab/providers/cart.dart';
import 'package:kabab/widgets/appDrawer.dart';
import 'package:kabab/widgets/badge.dart';
import 'package:kabab/widgets/categories_list.dart';
import 'package:provider/provider.dart';

import 'cart_screen1.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/homeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 20,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                padding: EdgeInsets.all(0),
                icon: Icon(
                  Icons.notification_important,
                ),
                onPressed: () {}),
            Consumer<Cart>(
              builder: (ctx, cart, ch) =>
                  Badge(child: ch, value: cart.cartList.length.toString()),
              child: IconButton(
                padding: EdgeInsets.all(0),
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen1.routeName);
                },
              ),
            ),
          ],
        ),
        leadingWidth: double.infinity,
        actions: [
          // DropdownButton(
          //   icon: Icon(
          //     Icons.more_vert,
          //     color: Colors.black,
          //     size: 30,
          //   ),
          //   underline: Container(
          //     color: Colors.amber,
          //   ),
          //   items: [
          //     DropdownMenuItem(
          //       child: Row(
          //         children: [
          //           Text('تسجيل الخروج '),
          //           Icon(Icons.exit_to_app),
          //         ],
          //       ),
          //       value: 'Logout',
          //     )
          //   ],
          //   onChanged: (_) {
          //     //  Provider.of<Auth>(context, listen: false).logout();
          //   },
          // ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/lo.jpg'), fit: BoxFit.contain),
          ),
        ),
      ),
      drawer: AppDrawer(),
      body: CategoriesList(),
    );
  }
}
