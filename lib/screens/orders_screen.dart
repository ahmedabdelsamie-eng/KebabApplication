import 'dart:ui';

import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الطلبات'),
      ),
      body: Container(
        color: Colors.white54,
        padding: EdgeInsets.all(5),
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                // color: Colors.teal,
                decoration: BoxDecoration(
                    border: Border.all(width: 1), color: Colors.teal),
                // width: double.infinity,
                child: Center(
                    child: Text(
                  'طلبات قيد التنفيذ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all(width: 1)),
                //width: ,
                child: Center(
                  child: Text(
                    'طلبات منتهية',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
