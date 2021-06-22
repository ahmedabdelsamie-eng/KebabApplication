import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expriyDate;
  String _userId;
  Timer _authTimer;
  bool get isAuth {
    return token != null;
  }

  String get userId {
    return _userId;
  }

  String get token {
    if (_expriyDate != null &&
        _expriyDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDOMh2vgt8pOGiGgpVo0aX6PGEHZWWj2Xs';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}),
      );

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];

      _userId = responseData['localId'];
      _expriyDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _autoLogout();
      notifyListeners();
      //your tunnel
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expriyDate': _expriyDate.toIso8601String()
      });
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future sendPasswordResetEmail(String email) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=AIzaSyDOMh2vgt8pOGiGgpVo0aX6PGEHZWWj2Xs';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({"requestType": "PASSWORD_RESET", "email": email}));
      print(json.decode(response.body));
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUP(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        jsonDecode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expriyDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedUserData['token'];

    _userId = extractedUserData['token'];
    _expriyDate = expiryDate;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expriyDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    //prefs.remove('userData);

    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeExpiry = _expriyDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeExpiry), () {
      print('i came here');
      logout();
      //  navService.pushNamedAndRemoveUntil(AuthScreen.routeName);
      //Get.offAll(MyCustomSplashScreen.routeName);
      print('test get');
      // Get.to(AuthScreen());
      Get.offAll(() => MyCustomSplashScreen());
    });
  }
}
