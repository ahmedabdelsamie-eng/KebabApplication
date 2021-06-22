import 'package:flutter/material.dart';
import 'package:kabab/customer/models/order_model.dart';
import 'package:kabab/customer/providers/order_resources.dart';
import 'package:provider/provider.dart';
import 'order_list_item.dart';

class OrderList extends StatelessWidget {
  final int gettedSign;
  OrderList({this.gettedSign});
  @override
  Widget build(BuildContext context) {
    List<OrderModel> toShowList;

    if (gettedSign == 1) {
      toShowList = Provider.of<Orders>(context).itsHour;
    } else {
      toShowList = Provider.of<Orders>(context).oldOrders;
    }
    if (toShowList.length == 0) {
      return Center(
        child: Text(
          'لم نتلقي اي طلبات',
          style: TextStyle(
              color: Colors.teal, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      );
    }
    return ListView(
      padding: EdgeInsets.all(20),
      children: toShowList
          .map(
            (ordmod) => OrderListItem(
              orderModel: ordmod,
            ),
          )
          .toList(),
    );
  }
}
