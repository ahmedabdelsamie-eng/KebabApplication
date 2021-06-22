import 'package:flutter/material.dart';
import 'package:kabab/customer/providers/cart_resources.dart';
import 'package:kabab/customer/screens/order_submit_screen.dart';
import 'package:kabab/customer/widgets/cart_gridlist.dart';
import 'package:provider/provider.dart';

class CartScreen2 extends StatelessWidget {
  static const routeName = '/cart-products-screen2';

  @override
  Widget build(BuildContext context) {
    final cartAccess = Provider.of<Cart>(context, listen: false);
    double b = cartAccess.getTotal();
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        title: Container(
          child: Text(
            'سلة التسوق',
            style: TextStyle(color: Colors.teal),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: CartGridList(),
          ),
          Card(
            color: Colors.teal,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'المبلغ الأجمالي ',
                    style: TextStyle(color: Colors.white),
                  ),
                  FittedBox(
                    child: Text(
                      ' شامل ضريبة القيمة المضافة ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    b.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationView(),
    );
  }
}

class BottomNavigationView extends StatefulWidget {
  @override
  _BottomNavigationViewState createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  String naviText = 'تأكيد الطلب';
  Color naviColor = Colors.amber;
  var ico = Icons.add_shopping_cart_sharp;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: Provider.of<Cart>(context, listen: false).cartList.length == 0
          ? null
          : () {
              Navigator.of(context).pushNamed(OrderSubmitScreen.routeName);
            },
      child: Container(
        height: 65,
        margin: EdgeInsets.only(left: 10, right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          child: BottomAppBar(
            color: naviColor,
            shape: CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  naviText,
                  style: TextStyle(
                      fontSize: 20,
                      wordSpacing: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
                SizedBox(
                  width: 25,
                ),
                Icon(
                  ico,
                  color: Colors.teal,
                  size: 28,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
