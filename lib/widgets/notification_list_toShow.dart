import 'package:flutter/material.dart';
import 'package:kabab/providers/notification.dart';
import 'package:provider/provider.dart';

class NotificationListToShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<NotificationMessage> not =
        Provider.of<Notificationy>(context).notificationList;
    return ListView(
      children: not
          .map((e) => Card(
                elevation: 20,
                child: ListTile(
                  title: Text(
                    e.title,
                    style: TextStyle(
                        color: Colors.pink, fontWeight: FontWeight.bold),
                  ),
                  subtitle: FittedBox(child: Text(e.date)),
                  trailing: Text(e.body),
                ),
              ))
          .toList(),
    );
  }
}
