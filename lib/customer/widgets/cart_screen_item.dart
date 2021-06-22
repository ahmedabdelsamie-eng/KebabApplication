import 'package:flutter/material.dart';
import 'package:kabab/customer/models/cartModel.dart';
import 'package:kabab/customer/providers/cart_resources.dart';
import 'package:provider/provider.dart';

import 'calc_cart_part.dart';

class CArtScreenItem extends StatelessWidget {
  final String id;
  final String title;
  final CartBoughtCan boughtCan;
  final String restuarantName;
  final String image;

  CArtScreenItem({
    this.id,
    this.title,
    this.boughtCan,
    this.restuarantName,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final cartDataAccess = Provider.of<Cart>(context, listen: false);

    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.amber),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(image),
                      radius: 30,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            restuarantName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            title,
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                FlatButton.icon(
                    onPressed: () {
                      cartDataAccess.removeCartItem(id);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.orange,
                    ),
                    label: Text('حذف')),
              ],
            ),
            Spacer(),
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'السعر :${boughtCan.cartBoughtCanPrice}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('${boughtCan.cartBoughtCanTitle}'),
                SizedBox(
                  height: 5,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: CalcPart(
                    boughtCan.cartBoughtCanQuantity,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
