import 'package:flutter/material.dart';
import 'package:kabab/providers/notification.dart';
import 'package:kabab/widgets/appDrawer.dart';
import 'package:kabab/widgets/notification_list_toShow.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatefulWidget {
  static const routeName = '/notification';

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String gettednotifiTilte;
  String gettednotifiBody;
  String gettednotifiDate;
  var init = true;
  var args;
  List<String> notList = [];

  @override
  void didChangeDependencies() {
    if (init) {
      args = ModalRoute.of(context).settings.arguments as Map<String, String>;
      print(args);
      args != null
          ? gettednotifiTilte = args['title']
          : gettednotifiTilte = null;
      args != null ? gettednotifiBody = args['body'] : gettednotifiTilte = null;
      args != null ? gettednotifiDate = args['date'] : gettednotifiTilte = null;
      if (args != null)
        Future.delayed(Duration(seconds: 1), () async {
          Provider.of<Notificationy>(context, listen: false).addNotification(
              gettednotifiTilte, gettednotifiBody, gettednotifiDate);
        });
    }
    init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('الاشعارات'),
        ),
        drawer: AppDrawer(),
        body: args == null
            ? Center(
                child: Text('لم تتلقي اى اشعارات..'),
              )
            : NotificationListToShow());
  }
}
