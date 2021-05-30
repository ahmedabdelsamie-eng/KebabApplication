// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:kabab/widgets/clippath.dart';

// enum AuthMode { Signup, Login }

// class AuthScreen extends StatefulWidget {
//   static const routeName = '/auth';

//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.black,
//       body: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.only(top: 25),
//           color: Colors.black,
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: Column(
//             children: [
//               Flexible(child: ClipScreen()),
//               Flexible(
//                   flex: 2,
//                   child: InkWell(
//                       onTap: () {
//                         FocusScope.of(context).unfocus();
//                       },
//                       child: AuthCard())),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AuthCard extends StatefulWidget {
//   const AuthCard({
//     Key key,
//   }) : super(key: key);

//   @override
//   _AuthCardState createState() => _AuthCardState();
// }

// class _AuthCardState extends State<AuthCard>
//     with SingleTickerProviderStateMixin {
//   final GlobalKey<FormState> _formKey = GlobalKey();
//   final _passwoordNode = FocusNode();

//   AuthMode _authMode = AuthMode.Login;
//   Map<String, String> _authData = {
//     'email': '',
//     'password': '',
//   };
//   var _isLoading = false;
//   final _passwordController = TextEditingController();
//   final _phoneController = TextEditingController();
//   AnimationController _controller;
//   Animation<Offset> _slideAnimation;
//   Animation<double> _opacityAnimation;
//   @override
//   void initState() {
//     _controller =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 300));
//     _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0)
//         .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
//     // _heightAnimation.addListener(() => setState(() {}));
//     _slideAnimation = Tween<Offset>(begin: Offset(0, -1.5), end: Offset(0, 0))
//         .animate(
//             CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text('An Error Occured!'),
//         content: Text(message),
//         actions: <Widget>[
//           // ignore: deprecated_member_use
//           FlatButton(
//             onPressed: () {
//               Navigator.of(ctx).pop();
//             },
//             child: Text('OKAy'),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _submit() async {
//     if (!_formKey.currentState.validate()) {
//       return;
//     }
//     FocusScope.of(context).unfocus();
//     setState(() {
//       _isLoading = true;
//     });
//     _formKey.currentState.save();
//   }

//   void _switchAuthMode() {
//     if (_authMode == AuthMode.Login) {
//       setState(() {
//         _authMode = AuthMode.Signup;
//       });
//       _controller.forward();
//     } else {
//       setState(() {
//         _authMode = AuthMode.Login;
//       });
//       _controller.reverse();
//     }
//   }

//   var hidden = true;
//   @override
//   Widget build(BuildContext context) {
//     final deviceSize = MediaQuery.of(context).size;
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       elevation: 0,
//       color: Colors.black,
//       margin: EdgeInsets.only(top: 50),
//       child: AnimatedContainer(
//         curve: Curves.easeIn,
//         duration: Duration(milliseconds: 300),
//         height: _authMode == AuthMode.Signup ? 450 : 300,
//         // height: _heightAnimation.value.height,

//         constraints: BoxConstraints(
//           minHeight: _authMode == AuthMode.Signup ? 450 : 300,
//         ),
//         width: deviceSize.width * 0.9,
//         padding: EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//             border: Border.all(width: 0.0, style: BorderStyle.none)),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 if (_authMode == AuthMode.Signup)
//                   CircleAvatar(
//                     radius: 40,
//                     backgroundColor: Colors.amber,
//                   ),
//                 if (_authMode == AuthMode.Signup)
//                   FlatButton.icon(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.image,
//                       color: Colors.white,
//                     ),
//                     label: Text(
//                       'Add Image',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 TextFormField(
//                   key: ValueKey('phone'),
//                   decoration: InputDecoration(
//                     labelText: 'Phone',
//                     //style of caption
//                     labelStyle: TextStyle(color: Colors.white),
//                     //focusColor: Colors.white,
//                     //  hintStyle: TextStyle(color: Colors.white),
//                     enabledBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(color: Colors.amber),
//                     ),
//                     suffixIcon: Icon(
//                       Icons.phone_enabled,
//                       color: Colors.white,
//                     ),
//                   ),
//                   //style of writting word
//                   style: TextStyle(color: Colors.white),
//                   controller: _phoneController,

//                   keyboardType: TextInputType.emailAddress,

//                   // ignore: missing_return
//                   validator: (value) {
//                     if (value.isEmpty || !value.contains('@')) {
//                       return 'Invalid email!';
//                     }
//                   },
//                   onSaved: (value) {
//                     _authData['email'] = value.trim();
//                   },
//                   textInputAction: TextInputAction.next,
//                   onFieldSubmitted: (_) {
//                     FocusScope.of(context).requestFocus(_passwoordNode);
//                   },
//                 ),
//                 TextFormField(
//                   key: ValueKey('paasword'),
//                   decoration: InputDecoration(
//                       labelText: 'Password',
//                       labelStyle: TextStyle(color: Colors.white),
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Colors.amber),
//                       ),
//                       suffixIcon: _phoneController.text.isEmpty
//                           ? GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   hidden = !hidden;
//                                 });
//                               },
//                               child: Icon(
//                                 Icons.remove_red_eye_outlined,
//                                 color: Colors.white,
//                               ),
//                             )
//                           : null),
//                   obscureText: hidden,
//                   style: TextStyle(color: Colors.white),
//                   controller: _passwordController,
//                   focusNode: _passwoordNode,

//                   // ignore: missing_return
//                   validator: (value) {
//                     if (value.isEmpty || value.length < 5) {
//                       return 'Password is too short!';
//                     }
//                   },
//                   onSaved: (value) {
//                     _authData['password'] = value.trim();
//                   },
//                 ),

//                 // ignore: deprecated_member_use
//                 SizedBox(
//                   height: 5,
//                 ),
//                 if (_authMode == AuthMode.Login)
//                   FlatButton(
//                     onPressed: () {},
//                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                     child: Text(
//                       //LocaleKeys.forget_text.tr(),
//                       'نسيت كلمة السر ؟',
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),

//                 AnimatedContainer(
//                   duration: Duration(milliseconds: 300),
//                   constraints: BoxConstraints(
//                       minHeight: _authMode == AuthMode.Signup ? 60 : 0,
//                       maxHeight: _authMode == AuthMode.Signup ? 120 : 0),
//                   child: FadeTransition(
//                     opacity: _opacityAnimation,
//                     child: SlideTransition(
//                       position: _slideAnimation,
//                       child: TextFormField(
//                         key: ValueKey('confirm_password'),
//                         enabled: _authMode == AuthMode.Signup,
//                         decoration: InputDecoration(
//                             labelText: 'confirm_password',
//                             labelStyle: TextStyle(color: Colors.white),
//                             enabledBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.amber))),
//                         obscureText: true,
//                         style: TextStyle(color: Colors.white),
//                         validator: _authMode == AuthMode.Signup
//                             // ignore: missing_return
//                             ? (value) {
//                                 if (value != _passwordController.text) {
//                                   return 'Passwords do not match!';
//                                 }
//                               }
//                             : null,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 if (_isLoading)
//                   CircularProgressIndicator()
//                 else
//                   // ignore: deprecated_member_use
//                   ElevatedButton(
//                     child: Text(
//                       _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
//                       style: TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                     onPressed: _submit,

//                     // shape: RoundedRectangleBorder(
//                     //   borderRadius: BorderRadius.circular(30),
//                     // ),
//                     // padding:
//                     //     EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
//                     // color: Theme.of(context).primaryColor,
//                     // textColor: Theme.of(context).primaryTextTheme.button.color,
//                   ),
//                 // ignore: deprecated_member_use
//                 FlatButton(
//                   child: Text(
//                     '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD',
//                     style: TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.bold),
//                   ),
//                   onPressed: _switchAuthMode,
//                   padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
//                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
