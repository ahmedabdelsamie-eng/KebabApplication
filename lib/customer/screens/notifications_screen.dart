import 'package:flutter/material.dart';
import 'package:kabab/customer/providers/notification_resources.dart';
import 'package:kabab/customer/widgets/appDrawer.dart';
import 'package:kabab/customer/widgets/notification_list_toShow.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatefulWidget {
  static const routeName = '/notification';

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String gettednotifiTilte;
  String gettednotifiBody;
  var gettednotifiDate;
  var init = true;
  var args;
  List<String> notList = [];

  @override
  void didChangeDependencies() {
    if (init) {
      args = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

      args != null
          ? gettednotifiTilte = args['title']
          : gettednotifiTilte = null;
      args != null ? gettednotifiBody = args['body'] : gettednotifiTilte = null;
      args != null ? gettednotifiDate = args['date'] : gettednotifiTilte = null;
      if (args != null)
        Future.delayed(Duration(milliseconds: 300), () async {
          Provider.of<NotificationResources>(context, listen: false)
              .addTONotification(
            gettednotifiDate,
            gettednotifiTilte,
            gettednotifiBody,
          );
        });
    }
    init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            child: Text(
              'الإشعارات',
              style: TextStyle(color: Colors.teal),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          leading: Builder(
            builder: (ctx) => IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  Scaffold.of(ctx).openDrawer();
                }),
          ),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future: Provider.of<NotificationResources>(context, listen: false)
                .getAndSetNotifications(),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (dataSnapshot.error != null) {
                return Center(
                  child: Text('حدث خطأ ما '),
                );
              } else {
                return Consumer<NotificationResources>(
                    builder: (ctx, notidata, child) => NotificationListToShow(
                        gettedList: notidata.notificationList));
              }
            }));
  }
}

// 