import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kabab/customer/providers/auth.dart';
import 'package:kabab/customer/providers/users_resources.dart';
import 'package:kabab/customer/widgets/clippath.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'forget_password_screen.dart';
import 'home_screen.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 25),
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Flexible(child: ClipScreen()),
              Flexible(
                  flex: 2,
                  child: InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: AuthCard())),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwoordNode = FocusNode();

  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  Map<String, String> _userdata = {
    'userName': '',
    'userImage': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacityAnimation;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    // _heightAnimation.addListener(() => setState(() {}));
    _slideAnimation = Tween<Offset>(begin: Offset(0, -1.5), end: Offset(0, 0))
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

  Future<void> _submit() async {
    if (savedImage == null && _authMode == AuthMode.Signup) {
      return;
    }
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email'], _authData['password']);

        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (_) => false);
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signUP(_authData['email'], _authData['password']);
        print('hell');
        await Provider.of<UsersResources>(context, listen: false)
            .addUser(_userdata['userName'], _userdata['userImage']);

        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (_) => false);
      }
    } on HttpException catch (error) {
      var errorMessage = '?????? ?????????? ????????????';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = '?????? ???????????? ???????????? ???? ??????';
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

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  var hidden = true;

////image
  File _storedImage;
  File savedImage;
  Future<void> _takePicture() async {
    final imageFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    File savedImage0 =
        await File(imageFile.path).copy('${appDir.path}/$fileName');
    setState(() {
      savedImage = savedImage0;
    });
    _userdata['userImage'] = savedImage.path;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 0,
      color: Colors.black,
      margin: EdgeInsets.only(top: 50),
      child: AnimatedContainer(
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 300),
        height: _authMode == AuthMode.Signup ? 480 : 300,
        // height: _heightAnimation.value.height,

        constraints: BoxConstraints(
          minHeight: _authMode == AuthMode.Signup ? 480 : 300,
        ),
        width: deviceSize.width * 0.9,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            border: Border.all(width: 0.0, style: BorderStyle.none)),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                if (_authMode == AuthMode.Signup)
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: _storedImage == null ? Colors.amber : null,
                    backgroundImage:
                        savedImage == null ? null : FileImage(savedImage),
                  ),
                if (_authMode == AuthMode.Signup)
                  FlatButton.icon(
                    onPressed: _takePicture,
                    icon: Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    label: Text(
                      '?????????? ????????',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                TextFormField(
                  key: ValueKey('E-mail'),
                  decoration: InputDecoration(
                    labelText: '???????????? ????????????????????',
                    //style of caption
                    labelStyle: TextStyle(color: Colors.white),
                    //focusColor: Colors.white,
                    //  hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                    suffixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                  ),
                  //style of writting word
                  style: TextStyle(color: Colors.white),
                  controller: _phoneController,

                  keyboardType: TextInputType.emailAddress,

                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                  },
                  onSaved: (value) {
                    _authData['email'] = value.trim();
                  },
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_passwoordNode);
                  },
                ),

                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  constraints: BoxConstraints(
                      minHeight: _authMode == AuthMode.Signup ? 30 : 0,
                      maxHeight: _authMode == AuthMode.Signup ? 40 : 0),
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: TextFormField(
                        key: ValueKey('userName'),
                        enabled: _authMode == AuthMode.Signup,
                        decoration: InputDecoration(
                            hintText: '?????? ????????????????',
                            hintStyle: TextStyle(color: Colors.white),
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber))),
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.white),
                        validator: _authMode == AuthMode.Signup
                            // ignore: missing_return
                            ? (value) {
                                if (value.isEmpty) {
                                  return '?????? ???????????? ????????';
                                }
                                return null;
                              }
                            : null,
                        onSaved: (value) {
                          _userdata['userName'] = value.trim();
                        },
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  key: ValueKey('paasword'),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      labelText: '???????? ????????????',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                      suffixIcon: _phoneController.text.isEmpty
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  hidden = !hidden;
                                });
                              },
                              child: Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.white,
                              ),
                            )
                          : null),
                  obscureText: hidden,
                  style: TextStyle(color: Colors.white),
                  controller: _passwordController,
                  focusNode: _passwoordNode,

                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value.trim();
                  },
                ),

                // ignore: deprecated_member_use
                SizedBox(
                  height: 5,
                ),
                if (_authMode == AuthMode.Login)
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(ForgotPassword.routeName);
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: Text(
                      //LocaleKeys.forget_text.tr(),
                      '???????? ???????? ???????????? ??',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),

                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  constraints: BoxConstraints(
                      minHeight: _authMode == AuthMode.Signup ? 30 : 0,
                      maxHeight: _authMode == AuthMode.Signup ? 40 : 0),
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: TextFormField(
                        key: ValueKey('confirm_password'),
                        enabled: _authMode == AuthMode.Signup,
                        decoration: InputDecoration(
                            hintText: '?????????? ???????? ????????????',
                            hintStyle: TextStyle(color: Colors.white),
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber))),
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        validator: _authMode == AuthMode.Signup
                            // ignore: missing_return
                            ? (value) {
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match!';
                                }
                              }
                            : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  // ignore: deprecated_member_use
                  ElevatedButton(
                    child: Text(
                      _authMode == AuthMode.Login
                          ? '?????????? ????????????'
                          : '?????? ???????? ????????',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: _submit,

                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(30),
                    // ),
                    // padding:
                    //     EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    // color: Theme.of(context).primaryColor,
                    // textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                // ignore: deprecated_member_use
                FlatButton(
                  child: Text(
                    '${_authMode == AuthMode.Login ? '?????? ???????? ????????' : '?????????? ????????????'} ',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 2),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
