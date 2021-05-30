import 'package:flutter/material.dart';
import 'package:kabab/screens/cart_screen2.dart';

class MainCArtScreenItem extends StatelessWidget {
  final String id;
  final String market;
  final String image;
  final String numberOfProds;
  final String totalPrice;

  MainCArtScreenItem({
    this.id,
    this.market,
    this.image,
    this.numberOfProds,
    this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(CartScreen2.routeName,
            arguments: {'market': market, 'total': totalPrice});
      },
      child: Card(
        elevation: 20,
        child: Container(
          // padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.amber),
          ),
          child: ListTile(
            leading: Container(
              height: 70,
              width: 70,
              child: Image.asset(
                'assets/images/fore.jpg',
                fit: BoxFit.cover,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            title: Text(
              market,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            subtitle: FittedBox(
              child: Text(
                'عدد المنتجات:' + numberOfProds,
                softWrap: false,
                style: TextStyle(
                    color: Colors.orange, fontWeight: FontWeight.bold),
              ),
            ),
            trailing: Text(
              'السعر: ' + totalPrice + '  ر س',
            ),
          ),
        ),
      ),
    );
  }
}
