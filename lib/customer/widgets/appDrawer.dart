import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kabab/customer/providers/auth.dart';
import 'package:kabab/customer/providers/users_resources.dart';
import 'package:kabab/customer/screens/home_screen.dart';
import 'package:kabab/customer/screens/language_screen.dart';
import 'package:kabab/customer/screens/search_part.dart';
import 'package:kabab/customer/screens/notifications_screen.dart';
import 'package:kabab/customer/screens/orders_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  void logoutLogic(BuildContext ctx) {
    Provider.of<Auth>(ctx, listen: false).logout();
    Navigator.pushNamedAndRemoveUntil(ctx, '/', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        // Set the transparency here
        canvasColor: Colors.transparent,
      ),
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/lo.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              profile(),
              Divider(
                color: Colors.white,
              ),
              Card(
                color: Colors.white.withOpacity(0.2),
                elevation: 10,
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: Text(
                    'الرئيسية',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                  },
                ),
              ),
              Card(
                color: Colors.white.withOpacity(0.2),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  title: Text(
                    'الملف الشخصي',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  onTap: () {},
                ),
              ),
              Card(
                color: Colors.white.withOpacity(0.2),
                child: ListTile(
                  leading: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  title: Text(
                    'الطلبات',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(OrdersScreen.routeName);
                  },
                ),
              ),
              Card(
                color: Colors.white.withOpacity(0.2),
                child: ListTile(
                  leading: Icon(
                    Icons.notification_important,
                    color: Colors.white,
                  ),
                  title: Text(
                    'الاشعارات',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(NotificationsScreen.routeName);
                  },
                ),
              ),
              Card(
                color: Colors.white.withOpacity(0.2),
                child: ListTile(
                  leading: Icon(
                    Icons.location_pin,
                    color: Colors.white,
                  ),
                  title: Text(
                    'العناوين',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  onTap: () {
                    // Navigator.of(context)
                    //     .pushReplacementNamed(LocationsScreen.routeName);
                  },
                ),
              ),
              Card(
                color: Colors.white.withOpacity(0.2),
                child: ListTile(
                  leading: Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  title: Text(
                    'اللغة',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LanguageScreen.routeName);
                  },
                ),
              ),
              Card(
                color: Colors.white.withOpacity(0.2),
                child: ListTile(
                  leading: Icon(
                    Icons.message,
                    color: Colors.white,
                  ),
                  title: Text(
                    'الشكاوى و المقترحات',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  onTap: () {},
                ),
              ),
              Card(
                color: Colors.white.withOpacity(0.2),
                child: ListTile(
                  leading: Icon(
                    Icons.adjust_rounded,
                    color: Colors.white,
                  ),
                  title: Text(
                    'الاسئلة المتكررة',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  onTap: () {},
                ),
              ),
              Card(
                color: Colors.white.withOpacity(0.2),
                child: ListTile(
                  leading: Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  title: Text(
                    'تسجيل الخروج',
                    style: TextStyle(
                        color: Colors.white,
                        wordSpacing: 8,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    logoutLogic(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class profile extends StatelessWidget {
  const profile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      var user = Provider.of<UsersResources>(context).users[0];
      return Row(children: [
        CircleAvatar(
          backgroundImage: FileImage(File(user.userImage)),
          radius: 50,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          'مرحبا بعودتك : ' + user.userNAme,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ]);
    } catch (error) {
      print(error);

      return Container(
        height: 0,
        width: 0,
      );
    }
  }
}
