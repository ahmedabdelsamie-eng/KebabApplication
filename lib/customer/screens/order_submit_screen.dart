import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kabab/customer/providers/cart_resources.dart';
import 'package:kabab/customer/providers/order_resources.dart';
import 'package:kabab/customer/widgets/location_input.dart';
import 'package:provider/provider.dart';

class OrderSubmitScreen extends StatefulWidget {
  static const routeName = 'order-submit-screen';

  @override
  _OrderSubmitScreenState createState() => _OrderSubmitScreenState();
}

class _OrderSubmitScreenState extends State<OrderSubmitScreen> {
  LatLng _fromLocationInput;
  int endTime = 0;

  String a = 'إرسال الأوردر';
  Color b = Colors.amber;
  var c = Icons.two_wheeler_sharp;
  void callbackforLocation({LatLng a}) {
    setState(() {
      _fromLocationInput = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_fromLocationInput);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Text(
            'تأكيد الأوردر',
            style: TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              color: Colors.white,
              width: 300,
              height: 120,
              child: Image.asset(
                'assets/images/lo.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              width: double.infinity,
              height: 50,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: FittedBox(
                    child: Text(
                      'حدد عنوانك علي الخريطة',
                      overflow: TextOverflow.visible,
                      softWrap: false,
                      style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 27),
                    ),
                  ),
                ),
              ),
            ),
            LocationInput(callbackforLocation),
            Container(
              margin: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: b,
                ),
                onPressed: _fromLocationInput == null
                    ? () {}
                    : () async {
                        try {
                          var d = Provider.of<Cart>(context, listen: false);

                          await Provider.of<Orders>(context, listen: false)
                              .addOrder(
                                  d.cartList.length, d.getTotal(), d.cartList);
                          setState(() {
                            b = Colors.teal;
                            c = Icons.done;
                            a = 'جاري توصيل الأوردر';
                            _fromLocationInput = null;
                            endTime = DateTime.now().millisecondsSinceEpoch +
                                1000 * 60;
                          });
                          Provider.of<Cart>(context, listen: false).clear();
                        } catch (error) {
                          await showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text('An Error Occured!'),
                              content: Text('حدث خطأ ما'),
                              actions: <Widget>[
                                // ignore: deprecated_member_use
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Text('OKAy'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                icon: Icon(
                  c,
                  size: 30,
                  color: Colors.white,
                ),
                label: Text(
                  a,
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 15,
              child: CountdownTimer(
                textStyle: TextStyle(
                    color: Colors.teal,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                endTime: endTime,
                endWidget: Text(''),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
