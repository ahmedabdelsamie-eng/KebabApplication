import 'package:flutter/material.dart';
import 'package:kabab/customer/providers/cart_resources.dart';
import 'package:kabab/customer/providers/notification_resources.dart';
import 'package:kabab/customer/providers/restuarants_resources.dart';
import 'package:kabab/customer/providers/users_resources.dart';
import 'package:kabab/customer/screens/cart_screen.dart';
import 'package:kabab/customer/screens/search_part.dart';
import 'package:kabab/customer/screens/notifications_screen.dart';
import 'package:kabab/customer/widgets/appDrawer.dart';
import 'package:kabab/customer/widgets/badge.dart';
import 'package:kabab/customer/widgets/carsoul.dart';
import 'package:kabab/customer/widgets/resturants_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var init = true;

  var gettedHeight = 85.0;
  void listHeight(double a) {
    setState(() {
      gettedHeight = a;
    });
  }

  @override
  void didChangeDependencies() {
    if (init) {
      Provider.of<UsersResources>(context, listen: false)
          .getUsersData()
          .then((_) => print('done'))
          .catchError((error) => print(error));
    }
    init = false;
    super.didChangeDependencies();
  }

  Future<bool> _onWillPop() {
    setState(() {
      gettedHeight = 85.0;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 20,
        leading: Builder(
          builder: (ctx) => IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.orange,
                size: 35,
              ),
              onPressed: () {
                Scaffold.of(ctx).openDrawer();
              }),
        ),
        //leadingWidth: double.infinity,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<NotificationResources>(
                builder: (ctx, noti, ch) =>
                    Badge(child: ch, value: noti.notificationCount.toString()),
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.notification_important,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(NotificationsScreen.routeName);
                  },
                ),
              ),
              Consumer<Cart>(
                builder: (ctx, cart, ch) =>
                    Badge(child: ch, value: cart.cartList.length.toString()),
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen2.routeName);
                  },
                ),
              ),
            ],
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/lo.jpg'), fit: BoxFit.contain),
          ),
        ),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Card(
            color: Colors.white,
            elevation: 15,
            child: Container(
              child: CarouselDemo(),
            ),
          ),
          WillPopScope(
            onWillPop: _onWillPop,
            child: Container(
              height: gettedHeight,
              child: SearchPart(
                sentHeight: listHeight,
              ),
              padding: EdgeInsets.all(5),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.black38,
              child: FutureBuilder(
                future: Provider.of<Restuarants>(context, listen: false)
                    .getrestuarantsData(),
                builder: (ctx, dataSnapshot) {
                  if (dataSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (dataSnapshot.error != null) {
                      return Center(
                        child: Text('an error occured'),
                      );
                    } else {
                      return Consumer<Restuarants>(
                          builder: (ctx, restuarantsData, child) =>
                              RestuarantsList(
                                  gettedList: restuarantsData.restuarants));
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
