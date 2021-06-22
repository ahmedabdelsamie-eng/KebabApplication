import 'package:flutter/cupertino.dart';

class UserModel {
  final String userId;
  final String userNAme;
  final String userImage;
  UserModel({
    this.userId,
    @required this.userNAme,
    @required this.userImage,
  });
}
