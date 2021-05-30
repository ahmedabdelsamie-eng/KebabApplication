import 'package:flutter/material.dart';
import 'package:kabab/models/cart_item.dart';
import 'package:kabab/providers/cart.dart';
import 'package:kabab/widgets/cart_gridlist.dart';
import 'package:provider/provider.dart';

class CartScreen2 extends StatelessWidget {
  static const routeName = '/cart-screen2';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    String gettedCategoryMarket = args['market'];
    String gettedCategoryTotalPrice = args['total'];
    List<CartItem> copiedCartList = Provider.of<Cart>(context).cartList;
    List<CartItem> categoryRelatedList = copiedCartList
        .where((cartItem) => cartItem.market == gettedCategoryMarket)
        .toList();
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
            child: CartGridList(
              gettedList: categoryRelatedList,
            ),
          ),
          Container(
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
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Spacer(),
                Text(
                  gettedCategoryTotalPrice,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 15,
                )
              ],
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
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(left: 10, right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomAppBar(
          color: Colors.amber,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'تأكيد الطلب',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
