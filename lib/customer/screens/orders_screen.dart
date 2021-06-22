import 'package:flutter/material.dart';
import 'package:kabab/customer/providers/order_resources.dart';
import 'package:kabab/customer/widgets/appDrawer.dart';
import 'package:kabab/customer/widgets/orders_list.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var init = true;
  var isloading = false;
  @override
  void didChangeDependencies() {
    if (init) {
      print('njjjjjjjjnjnjj');
      setState(() {
        isloading = true;
      });
      Provider.of<Orders>(context, listen: false)
          .getAndSetOrders()
          .then((_) => setState(() {
                isloading = false;
              }))
          .catchError((error) => print(error));
    }
    init = false;
    super.didChangeDependencies();
  }

  var sign = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          child: Text(
            'الطلبات',
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
        leading: Builder(
          builder: (ctx) => IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
                size: 35,
              ),
              onPressed: () {
                Scaffold.of(ctx).openDrawer();
              }),
        ),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Card(
            elevation: 20,
            child: Container(
              width: double.infinity,
              color: Colors.amber[100],
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        sign = 1;
                      });
                    },
                    child: Text(
                      'طلبات قيد التنفيذ',
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          sign = 2;
                        });
                      },
                      child: Text(
                        'الطلبات  السابقة',
                        style: TextStyle(color: Colors.amber),
                      ))
                ],
              ),
            ),
          ),
          Expanded(
              child: Container(
            color: Colors.amber[100],
            child: isloading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : OrderList(
                    gettedSign: sign,
                  ),
          ))
        ],
      ),
    );
  }
}
 // Container(
          //   color: Colors.white54,
          //   padding: EdgeInsets.all(5),
          //   width: double.infinity,
          //   height: 50,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Expanded(
          //         child: Container(
          //           // color: Colors.teal,
          //           decoration: BoxDecoration(
          //               border: Border.all(width: 1), color: Colors.teal),
          //           // width: double.infinity,
          //           child: Center(
          //               child: Text(
          //             'طلبات قيد التنفيذ',
          //             style: TextStyle(fontWeight: FontWeight.bold),
          //           )),
          //         ),
          //       ),
          //       Expanded(
          //         child: Container(
          //           decoration: BoxDecoration(border: Border.all(width: 1)),
          //           //width: ,
          //           child: Center(
          //             child: Text(
          //               'طلبات منتهية',
          //               style: TextStyle(fontWeight: FontWeight.bold),
          //             ),
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // )