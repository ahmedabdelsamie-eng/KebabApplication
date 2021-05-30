import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:kabab/providers/cart.dart';
import 'package:kabab/widgets/calc.dart';
import 'package:provider/provider.dart';

class SectionItemDetailsScreen extends StatefulWidget {
  static const routeName = '/se-item-det-screen';

  @override
  _SectionItemDetailsScreenState createState() =>
      _SectionItemDetailsScreenState();
}

class _SectionItemDetailsScreenState extends State<SectionItemDetailsScreen> {
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
  String title;
  String image;
  String market;
  String price;
  Map<String, String> cansprices;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (init) {
      final args =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      id = args['id'];
      title = args['title'];
      image = args['image'];
      market = args['market'];
      price = args['price'];
      cansprices = args['cansprices'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Container(
                width: double.infinity,
                height: 260,
                color: Colors.teal,
                child: Hero(
                  tag: id,
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
            ]),
            Container(
              height: 260,
              //color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: DefaultTextStyle(
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.teal),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText(
                            title + ' :',
                          )
                        ],
                        repeatForever: true,
                        isRepeatingAnimation: true,
                      ),
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
                                cansprices['small'] + ' ' + 'ر س',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                cansprices['medium'] + ' ' + 'ر س',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                cansprices['large'] + ' ' + 'ر س',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          BuyCalc(countNum),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationView(id, title, image, market, price,
          cansprices, countNum1, countNum2, countNum3),
    );
  }
}

class BottomNavigationView extends StatefulWidget {
  final String gettedItemId;
  final String gettedItemTitle;
  final String gettedItemImage;
  final String gettedItemMarket;
  final String gettedItemPrice;
  final Map<String, String> gettedItemBoughtCan;
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

  String priceofcanpart;

  int quantity;

  int changeTotal(int a, int b, int c) {
    if (a != 0) {
      canpart = 'small';
      quantity = a;
      priceofcanpart = widget.gettedItemBoughtCan['small'];
      return (a * int.parse(widget.gettedItemPrice));
    } else if (b != 0) {
      canpart = 'medium';
      quantity = b;
      priceofcanpart = widget.gettedItemBoughtCan['medium'];
      return (b * 3 * int.parse(widget.gettedItemPrice));
    } else if (c != 0) {
      canpart = 'large';
      quantity = c;
      priceofcanpart = widget.gettedItemBoughtCan['large'];
      return (c * 5 * int.parse(widget.gettedItemPrice));
    } else {
      return 0;
    }
  }

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
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton.icon(
                onPressed: widget.gettedcount1 == 0 &&
                        widget.gettedcount2 == 0 &&
                        widget.gettedcount3 == 0
                    ? null
                    : () {
                        print(canpart);
                        var result = Provider.of<Cart>(context, listen: false)
                            .cartList
                            .any((element) =>
                                element.dadId == widget.gettedItemId &&
                                element.boughtCan.containsKey(canpart));
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

                        Provider.of<Cart>(context, listen: false).addTOCart(
                            widget.gettedItemId,
                            widget.gettedItemTitle,
                            widget.gettedItemImage,
                            widget.gettedItemMarket,
                            canpart,
                            priceofcanpart,
                            quantity.toString());
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
                        fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                ),
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                  size: 30,
                ),
                hoverColor: Colors.amber,
              ),
              Row(
                children: [
                  Text(
                    'المجموع :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  Text(
                    ' ${changeTotal(widget.gettedcount1, widget.gettedcount2, widget.gettedcount3)} ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.amber),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
