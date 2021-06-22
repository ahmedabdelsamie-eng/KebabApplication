import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kabab/customer/models/user_model.dart';

class UsersResources with ChangeNotifier {
  List<UserModel> _users;
  List<UserModel> get users {
    return _users;
  }

  // String token;
  String userId;
  UsersResources(this.userId, this._users);

  Future<void> addUser(
    String userName,
    String userImage,
  ) async {
    final url =
        'https://kabab-b464b-default-rtdb.firebaseio.com/users/$userId.json';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'userName': userName,
            'userImage': userImage,
          },
        ),
      );
      print(json.decode(response.body));
      _users.add(UserModel(
          userId: json.decode(response.body)['name'],
          userNAme: userName,
          userImage: userImage));
      print(_users.length * 20);

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> getUsersData() async {
    final url =
        'https://kabab-b464b-default-rtdb.firebaseio.com/users/$userId.json';

    try {
      final response = await http.get(Uri.parse(url));
      List<UserModel> loadedData = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(444444444444444);
      if (extractedData == null) {
        return null;
      }
      print(json.decode(response.body));
      print(2222222222222);

      extractedData.forEach((userModelId, userModelData) {
        print(userModelData.toString());

        loadedData.add(UserModel(
          userId: userModelId,
          userNAme: userModelData['userName'],
          userImage: userModelData['userImage'],
        ));
      });
      print(777777);

      _users = loadedData;
      print(json.decode(response.body));
      print('llllllllllllllllllllll');
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
