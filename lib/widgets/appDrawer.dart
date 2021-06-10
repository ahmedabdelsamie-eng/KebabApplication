import 'package:flutter/material.dart';
import 'package:kabab/main.dart';
import 'package:kabab/providers/auth.dart';
import 'package:kabab/screens/home_screen.dart';
import 'package:kabab/screens/language_screen.dart';
import 'package:kabab/screens/locations_screen.dart';
import 'package:kabab/screens/notifications_screen.dart';
import 'package:kabab/screens/orders_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  void logoutLogic(BuildContext ctx) {
    Provider.of<Auth>(ctx, listen: false).logout();
    Navigator.pushNamedAndRemoveUntil(ctx, '/', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              title: Text('kabab'),
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/lo.jpg'),
                radius: 25,
              ),
              title: Text('UserName'),
              onTap: () {},
            ),
            Divider(),
            Card(
              elevation: 10,
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text('الرئيسية'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .pushReplacementNamed(HomeScreen.routeName);
                },
              ),
            ),
            Card(
              elevation: 10,
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('الملف الشخصي'),
                onTap: () {},
              ),
            ),
            Card(
              elevation: 10,
              child: ListTile(
                leading: Icon(Icons.menu),
                title: Text('الطلبات'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(OrdersScreen.routeName);
                },
              ),
            ),
            Card(
              elevation: 10,
              child: ListTile(
                leading: Icon(Icons.notification_important),
                title: Text('الاشعارات'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(NotificationsScreen.routeName);
                },
              ),
            ),
            Card(
              elevation: 10,
              child: ListTile(
                leading: Icon(
                  Icons.location_pin,
                ),
                title: Text('العناوين'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(LocationsScreen.routeName);
                },
              ),
            ),
            Card(
              elevation: 10,
              child: ListTile(
                leading: Icon(Icons.language),
                title: Text('اللغة'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(LanguageScreen.routeName);
                },
              ),
            ),
            Card(
              elevation: 10,
              child: ListTile(
                leading: Icon(Icons.message),
                title: Text('الشكاوى و المقترحات'),
                onTap: () {},
              ),
            ),
            Card(
              elevation: 10,
              child: ListTile(
                leading: Icon(Icons.adjust_rounded),
                title: Text('الاسئلة المتكررة'),
                onTap: () {},
              ),
            ),
            Card(
              elevation: 10,
              child: ListTile(
                leading: Icon(Icons.info),
                title: Text('تسجيل الخروج'),
                onTap: () {
                  Navigator.of(context).pop();
                  logoutLogic(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
