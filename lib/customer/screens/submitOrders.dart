import 'package:flutter/material.dart';
import 'package:kabab/customer/widgets/cart_gridlist.dart';

class CartSubmitOrdersScreen extends StatelessWidget {
  static const routeName = '/cart-submitOrders-screen2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        title: Container(
          child: Text(
            'طلباتك',
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
  @override
  Widget build(BuildContext context) {
    return Container(
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
          color: Colors.amber,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ' الطلب',
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
                Icons.done,
                color: Colors.white,
                size: 28,
              )
            ],
          ),
        ),
      ),
    );
  }
}
