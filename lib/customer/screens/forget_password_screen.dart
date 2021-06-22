import 'package:flutter/material.dart';
import 'package:kabab/customer/models/http_exception.dart';
import 'package:kabab/customer/providers/auth.dart';
import 'package:kabab/customer/screens/home_screen.dart';
import 'package:kabab/customer/widgets/clippath.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = 'forgot-password-screen';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey2 = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  String resetPassword = '';
  var _isLoading = false;

  GlobalKey<FormState> _formKey = GlobalKey();
  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) return;
    FocusScope.of(context).unfocus();
    _formKey.currentState.save();
    try {
      await Provider.of<Auth>(context, listen: false)
          .sendPasswordResetEmail(resetPassword);
      setState(() {
        title = 'تم التواصل مع الحساب';
      });
    } catch (error) {
      print('error-forget-pass');
    }
  }

  var title = 'أدخل الحساب الخاص بك';

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occured!'),
        content: Text(message),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OKAy'),
          ),
        ],
      ),
    );
  }

  Future<void> _submitLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .login(_authData['email'], _authData['password']);

      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.routeName, (_) => false);
    } on HttpException catch (error) {
      var errorMessage = 'فشل تسجيل الدخول';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'هذا الحساب مستخدم من قبل';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'this is not a valid email address ';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'this password is to weak ';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'could not find a user with that email ';
      } else if (error.toString().contains('INVALID_PASSWORd')) {
        errorMessage = 'invalid password';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Authentication could not,please try again later';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipScreen(),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber),
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'الحساب الألكترونى',
                        icon: Icon(
                          Icons.mail,
                          color: Colors.amber,
                        ),
                        errorStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Invalid email!';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        resetPassword = value;
                        _authData['email'] = value.trim();
                      },
                    ),
                    if (title != 'أدخل الحساب الخاص بك')
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'كلمة المرور',
                          icon: Icon(
                            Icons.lock,
                            color: Colors.amber,
                          ),
                          errorStyle: TextStyle(color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        // ignore: missing_return
                        validator: (value) {
                          if (value.isEmpty || value.length < 5) {
                            return 'Password is too short!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['password'] = value.trim();
                        },
                      ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          child: Text(
                            'تغيير كلمة السر',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          onPressed: _submit,
                          color: Colors.amber,
                        ),
                        if (_isLoading)
                          CircularProgressIndicator()
                        else
                          RaisedButton(
                            child: Text('تسجيل الدخول',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                            onPressed: _submitLogin,
                            color: Colors.amber,
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
