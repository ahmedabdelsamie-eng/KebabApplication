import 'package:flutter/material.dart';

class NotificationMessage {
  final String title;
  final String body;
  final String date;
  NotificationMessage({this.title, this.body, this.date});
}

class Notificationy with ChangeNotifier {
  List<NotificationMessage> _notificationList = [];
  List<NotificationMessage> get notificationList {
    return [..._notificationList];
  }

  void addNotification(String title, String body, String datee) {
    _notificationList
        .add(NotificationMessage(title: title, body: body, date: datee));

    notifyListeners();
  }
}
