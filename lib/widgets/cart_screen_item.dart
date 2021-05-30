import 'package:flutter/material.dart';
import 'package:kabab/providers/cart.dart';
import 'package:provider/provider.dart';
import 'calc_cart_part.dart';

class CArtScreenItem extends StatelessWidget {
  final String id;
  final String title;
  final Map<String, Map<String, Object>> boughtCan;
  final String market;
  final String image;

  CArtScreenItem({
    this.id,
    this.title,
    this.boughtCan,
    this.market,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final cartDataAccess = Provider.of<Cart>(context, listen: false);

    return Card(
      elevation: 20,
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
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            market,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 9),
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
                      cartDataAccess.removeCartItem(
                          id,
                          market,
                          boughtCan.values.toList()[0]['price'],
                          boughtCan.values.toList()[0]['quantity']);
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
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'السعر: ' + boughtCan.values.toList()[0]['price'] + ' ر س',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(boughtCan.keys.toList()[0] == 'small'
                    ? ' صغير'
                    : boughtCan.keys.toList()[0] == 'medium'
                        ? 'وسط'
                        : 'كبير'),
                SizedBox(
                  height: 5,
                ),
                CalcPart(
                  int.parse(boughtCan.values.toList()[0]['quantity']),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
