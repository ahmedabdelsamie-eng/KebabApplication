import 'package:flutter/cupertino.dart';

class NotificationModel {
  var notificationDateTime;
  final String notificationTitle;
  final String notificationBody;

  NotificationModel({
    @required this.notificationDateTime,
    @required this.notificationTitle,
    @required this.notificationBody,
  });
}
