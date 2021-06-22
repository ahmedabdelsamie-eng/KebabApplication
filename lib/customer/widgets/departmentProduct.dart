import 'package:flutter/material.dart';
import 'package:kabab/customer/models/restuarantModel.dart';
import 'package:kabab/customer/screens/department_product_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:kabab/customer/providers/cart_resources.dart';

class DepartmentProduct extends StatefulWidget {
  final String productId;
  final String name;
  final String image;
  final String dept;
  final String restuarantName;
  final int price;
  final CansPrices cansPrices;
  DepartmentProduct(
      {@required this.productId,
      @required this.name,
      @required this.image,
      @required this.dept,
      @required this.restuarantName,
      @required this.price,
      @required this.cansPrices});

  @override
  _DepartmentProductState createState() => _DepartmentProductState();
}

class _DepartmentProductState extends State<DepartmentProduct> {
  var a = Text('Add To Cart');
  var b = Icon(Icons.shopping_cart);
  var c = Colors.amber;

  @override
  Widget build(BuildContext context) {
    print(widget.dept + 'zzzzzzzzzzzzzzzzzzzzzzzz');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            print(widget.name);
            Navigator.of(context).pushNamed(
              DepartmentProductDetailsScreen.routeName,
              arguments: {
                'prodId': widget.productId,
                'prodName': widget.name,
                'prodImage': widget.image,
                'prodRestuarant': widget.restuarantName,
                'dept': widget.dept,
                'prodPrice': widget.price,
                'prodCansprices': widget.cansPrices
              },
            );
          },
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              height: 150,
              child: GridTile(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: double.infinity,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.asset(
                            widget.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 2,
                      top: 2,
                      child: Row(
                        children: [
                          Text(
                            '0',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 30,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.black45,
                        width: 120,
                        height: 50,
                        child: Text(
                          widget.name,
                          overflow: TextOverflow.visible,
                          softWrap: false,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        FlatButton.icon(
          onPressed: () {
            setState(() {
              a = Text('done');
              b = Icon(Icons.done);
              c = Colors.teal;
            });
            Provider.of<Cart>(context, listen: false).addTOCart(
                widget.productId,
                widget.name,
                widget.image,
                widget.price,
                widget.restuarantName,
                'صغير',
                widget.cansPrices.kilo,
                1);
          },
          label: a,
          icon: b,
          color: c,
        ),
      ],
    );
  }
}
