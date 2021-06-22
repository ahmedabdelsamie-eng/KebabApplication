import 'package:flutter/material.dart';
import 'package:kabab/customer/models/restuarantModel.dart';
import 'package:kabab/customer/providers/cart_resources.dart';
import 'package:kabab/customer/widgets/calc.dart';
import 'package:kabab/customer/widgets/related_items_grid.dart';
import 'package:provider/provider.dart';

class DepartmentProductDetailsScreen extends StatefulWidget {
  static const routeName = '/se-item-det-screen';

  @override
  _DepartmentProductDetailsScreen createState() =>
      _DepartmentProductDetailsScreen();
}

class _DepartmentProductDetailsScreen
    extends State<DepartmentProductDetailsScreen> {
  var countNum1 = 0;

  var countNum2 = 0;

  var countNum3 = 0;

  void countNum(int cNum1, cNum2, cNum3) {
    if (cNum1 >= 0) {
      setState(() {
        countNum1 = cNum1;
      });
    }
    if (cNum2 >= 0) {
      setState(() {
        countNum2 = cNum2;
      });
    }
    if (cNum3 >= 0) {
      setState(() {
        countNum3 = cNum3;
      });
    }
  }

  var init = true;
  String id;
  String name;
  String image;
  String restuarantName;
  String dept;
  int price;
  CansPrices cansprices;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (init) {
      final args =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      id = args['prodId'];
      name = args['prodName'];
      dept = args['dept'];
      image = args['prodImage'];
      restuarantName = args['prodRestuarant'];
      price = args['prodPrice'];
      cansprices = args['prodCansprices'];
    }
    init = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 260,
                  // child: Hero(
                  //   tag: id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 8,
                  bottom: 5,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black),
                    padding: EdgeInsets.all(3),
                    child: Row(
                      children: [
                        Text(
                          '0',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.amber[100],
              height: 260,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Text(
                      ' $name  :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.teal),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      right: 5,
                    ),
                    width: double.infinity,
                    child: Text(
                      'وجبة طيبة شهية لذيذة ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      color: Colors.white54,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30)),
                      ),
                      elevation: 2,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        //height: 90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'صغير' // + itemCan['kilo']
                                  ,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'وسط' //+ itemCan['bx3']
                                  ,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'كبير' // + itemCan['bx5']
                                  ,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '${cansprices.kilo} رس',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${cansprices.kilo3} رس',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${cansprices.kilo5} رس',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            BuyCalc(countNum),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 9),
              height: 30,
              child: Text(
                'منتجات ذات صلة :',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            RelatedGrid(dept, restuarantName),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationView(id, name, image, restuarantName,
          price, cansprices, countNum1, countNum2, countNum3),
    );
  }
}

class BottomNavigationView extends StatefulWidget {
  final String gettedItemId;
  final String gettedItemTitle;
  final String gettedItemImage;
  final String gettedItemMarket;
  final int gettedItemPrice;
  CansPrices gettedItemBoughtCan;
  final int gettedcount1;
  final int gettedcount2;
  final int gettedcount3;

  BottomNavigationView(
    this.gettedItemId,
    this.gettedItemTitle,
    this.gettedItemImage,
    this.gettedItemMarket,
    this.gettedItemPrice,
    this.gettedItemBoughtCan,
    this.gettedcount1,
    this.gettedcount2,
    this.gettedcount3,
  );
  @override
  _BottomNavigationViewState createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  String canpart;

  int priceofcanpart;

  int quantity;

  int total(int a, int b, int c) {
    if (a != 0) {
      canpart = 'صغير';
      quantity = a;
      priceofcanpart = widget.gettedItemBoughtCan.kilo;
      return (a * widget.gettedItemBoughtCan.kilo);
    } else if (b != 0) {
      canpart = 'وسط';
      quantity = b;
      priceofcanpart = widget.gettedItemBoughtCan.kilo3;
      return (b * widget.gettedItemBoughtCan.kilo3);
    } else if (c != 0) {
      canpart = 'كبير';
      quantity = c;
      priceofcanpart = widget.gettedItemBoughtCan.kilo5;
      return (c * widget.gettedItemBoughtCan.kilo5);
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber[100],
      child: Row(
        children: [
          Expanded(
            child: Container(
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
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FlatButton.icon(
                        onPressed: widget.gettedcount1 == 0 &&
                                widget.gettedcount2 == 0 &&
                                widget.gettedcount3 == 0
                            ? null
                            : () {
                                var result =
                                    Provider.of<Cart>(context, listen: false)
                                        .cartList
                                        .any((element) =>
                                            element.cartDadId ==
                                                widget.gettedItemId &&
                                            element.cartBoughtCan
                                                    .cartBoughtCanTitle ==
                                                canpart);
                                if (result) {
                                  Scaffold.of(context).hideCurrentSnackBar();
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.black38,
                                      content: Text(
                                        'تم إضافة العنصر هذا مسبقا',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.amber),
                                      ),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                  return;
                                }

                                Provider.of<Cart>(context, listen: false)
                                    .addTOCart(
                                        widget.gettedItemId,
                                        widget.gettedItemTitle,
                                        widget.gettedItemImage,
                                        widget.gettedItemPrice,
                                        widget.gettedItemMarket,
                                        canpart,
                                        priceofcanpart,
                                        quantity);

                                Scaffold.of(context).hideCurrentSnackBar();
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.black38,
                                    content: Text(
                                      'قمت بإضافة عنصر للسلة',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amber),
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                        label: FittedBox(
                          child: Text(
                            'إضافة للسلة',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                        ),
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 30,
                        ),
                        hoverColor: Colors.amber,
                      ),
                      Row(
                        children: [
                          Text(
                            'التكلفة :',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                          Text(
                            ' ${total(widget.gettedcount1, widget.gettedcount2, widget.gettedcount3)} ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
