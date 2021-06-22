import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kabab/customer/models/notification_model.dart';

class NotificationResources with ChangeNotifier {
  List<NotificationModel> _notificationList = [];
  List<NotificationModel> get notificationList {
    return [..._notificationList];
  }

  String token;
  NotificationResources(this.token, this._notificationList);

  Future<void> addTONotification(
    DateTime notificationDateTime,
    String notificationTitle,
    String notificationBody,
  ) async {
    final url =
        'https://kabab-b464b-default-rtdb.firebaseio.com/notifications.json?auth=$token';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'notificationDateTime': notificationDateTime.toIso8601String(),
            'notificationTitle': notificationTitle,
            'notificationBody': notificationBody,
          },
        ),
      );
      _notificationList.add(
        NotificationModel(
            notificationDateTime: notificationDateTime.toIso8601String(),
            notificationTitle: notificationTitle,
            notificationBody: notificationBody),
      );
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> getAndSetNotifications() async {
    final url =
        'https://kabab-b464b-default-rtdb.firebaseio.com/notifications.json?auth=$token';
    try {
      final response = await http.get(Uri.parse(url));
      final List<NotificationModel> loadedData = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData == null) {
        return;
      }
      extractedData.forEach((orderId, notificationData) {
        loadedData.add(NotificationModel(
            notificationDateTime: notificationData['notificationDateTime'],
            notificationTitle: notificationData['notificationTitle'],
            notificationBody: notificationData['notificationBody']));
      });
      _notificationList = loadedData.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  int get notificationCount {
    if (_notificationList.length == 0) {
      return 0;
    }
    return _notificationList.length;
  }
}
