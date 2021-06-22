import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kabab/customer/models/order_model.dart';
import 'package:slimy_card/slimy_card.dart';

class OrderListItem extends StatelessWidget {
  final OrderModel orderModel;
  OrderListItem({this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SlimyCard(
        color: Colors.black,
        width: 300,
        topCardHeight: 150,
        bottomCardHeight: 100,
        borderRadius: 15,
        topCardWidget: myWidgetTop(),
        bottomCardWidget: myWidgetBottom(),
        slimeEnabled: true,
      ),
    );
  }

  Widget myWidgetTop() {
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedTime = DateFormat('kk:mm:a')
        .format((DateTime.parse(orderModel.orderDateAsId)));
    String formattedDate =
        formatter.format((DateTime.parse(orderModel.orderDateAsId)));
    return Column(
      children: [
        Row(
          children: [
            Text(
              ' تاريخ الأوردر  : ',
              style: TextStyle(color: Colors.amber),
            ),
            Text(formattedDate, style: TextStyle(color: Colors.white)),
          ],
        ),
        Row(
          children: [
            Text(' توقيت الأوردر  : ', style: TextStyle(color: Colors.amber)),
            Text(formattedTime, style: TextStyle(color: Colors.white)),
          ],
        ),
        Row(
          children: [
            Text(' تكلفة الأوردر  : ', style: TextStyle(color: Colors.amber)),
            Text(orderModel.totalCostOfOrder.toString(),
                style: TextStyle(color: Colors.white)),
          ],
        ),
        Text('مزيد من التفاصيل', style: TextStyle(color: Colors.amber))
      ],
    );
  }

  Widget myWidgetBottom() {
    return Column(
      children: [
        Row(
          children: [
            Text(' عدد المنتجات  : ', style: TextStyle(color: Colors.amber)),
            Text(orderModel.numberOfProducts.toString(),
                style: TextStyle(color: Colors.white)),
          ],
        ),
        Expanded(
          child: Container(
            child: ListView(
              children: orderModel.orderDetails
                  .map((e) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                              e.cartBoughtCan.cartBoughtCanQuantity.toString() +
                                  ' * ',
                              style: TextStyle(color: Colors.white)),
                          Text(e.cartName,
                              style: TextStyle(color: Colors.white)),
                          Text(e.cartBoughtCan.cartBoughtCanTitle,
                              style: TextStyle(color: Colors.white)),
                          Text(e.cartRestuarantName,
                              style: TextStyle(color: Colors.white)),
                          Text('السعر', style: TextStyle(color: Colors.white)),
                          Text(e.cartBoughtCan.cartBoughtCanPrice.toString(),
                              style: TextStyle(color: Colors.white)),
                        ],
                      ))
                  .toList(),
            ),
          ),
        ),
        Text('تم التوصيل مسبقا', style: TextStyle(color: Colors.amber)),
      ],
    );
  }
}



   // return InkWell(
    //   onTap: () {},
    //   child: Card(
    //     elevation: 20,
    //     child: Container(
    //       height: 80,
    //       decoration: BoxDecoration(
    //         border: Border.all(color: Colors.amber),
    //       ),
    //       child: ListTile(
    //         leading: Container(
    //           height: 70,
    //           width: 70,
    //           child: Text('orderModel.numberOfProducts.toString()),'),
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(5),
    //           ),
    //         ),
    //         title: Text(
    //           'sss',
    //           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
    //         ),
    //         subtitle: FittedBox(
    //           child: Text(
    //             'عدد المنتجات:',
    //             softWrap: false,
    //             style: TextStyle(
    //                 color: Colors.orange, fontWeight: FontWeight.bold),
    //           ),
    //         ),
    //         trailing: Text(
    //           '  ر س',
    //         ),
    //       ),
    //     ),
    //   ),
    // );