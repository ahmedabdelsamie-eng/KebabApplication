import 'package:flutter/material.dart';
import 'package:kabab/customer/models/notification_model.dart';
import 'package:kabab/customer/providers/notification_resources.dart';
import 'package:provider/provider.dart';

class NotificationListToShow extends StatelessWidget {
  final List<NotificationModel> gettedList;
  NotificationListToShow({this.gettedList});
  @override
  Widget build(BuildContext context) {
    // List<NotificationModel> noti =
    //     Provider.of<NotificationResources>(context).notificationList;
    if (gettedList.length == 0) {
      return Center(
        child: Text(
          'لم تتلقي أى إشعارات',
          style: TextStyle(
              color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
    }
    return ListView(
      children: gettedList
          .map((e) => Card(
                elevation: 20,
                child: ListTile(
                  title: Text(
                    e.notificationTitle,
                    style: TextStyle(
                        color: Colors.pink, fontWeight: FontWeight.bold),
                  ),
                  subtitle:
                      FittedBox(child: Text(e.notificationDateTime.toString())),
                  trailing: Text(e.notificationBody),
                ),
              ))
          .toList(),
    );
  }
}
