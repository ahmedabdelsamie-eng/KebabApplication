// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:kabab/providers/auth.dart';
// import 'package:kabab/screens/auth_screen.dart';
// import 'package:kabab/screens/home_screen.dart';
// import 'package:provider/provider.dart';

// class MyCustomSplashScreen extends StatefulWidget {
//   static const routeName = '/custom-splash';
//   @override
//   _MyCustomSplashScreenState createState() => _MyCustomSplashScreenState();
// }

// class _MyCustomSplashScreenState extends State<MyCustomSplashScreen>
//     with TickerProviderStateMixin {
//   double _fontSize = 2;
//   double _containerSize = 1.5;
//   double _textOpacity = 0.0;
//   double _containerOpacity = 0.0;

//   AnimationController _controller;
//   Animation<double> animation1;

//   @override
//   void initState() {
//     super.initState();

//     _controller =
//         AnimationController(vsync: this, duration: Duration(seconds: 1));

//     animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
//         parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
//       ..addListener(() {
//         setState(() {
//           _textOpacity = 1.0;
//         });
//       });

//     _controller.forward();

//     Timer(Duration(seconds: 2), () {
//       setState(() {
//         _fontSize = 1.06;
//       });
//     });

//     Timer(Duration(seconds: 2), () {
//       setState(() {
//         _containerSize = 2;
//         _containerOpacity = 1;
//       });
//     });
//     Timer(Duration(seconds: 4), () {
//       setState(() {
//         Provider.of<Auth>(context, listen: false).tryAutoLogin().then((value) {
//           print(value);
//           return value == false
//               ? Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(
//                     builder: (ctx) => AuthScreen(),
//                   ),
//                 )
//               : Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(
//                     builder: (ctx) => HomeScreen(),
//                   ),
//                 );
//         });
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double _width = MediaQuery.of(context).size.width;
//     double _height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: Color.fromRGBO(255, 202, 6, 1),
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               AnimatedContainer(
//                   duration: Duration(milliseconds: 2000),
//                   curve: Curves.fastLinearToSlowEaseIn,
//                   height: _height / _fontSize),
//               AnimatedOpacity(
//                 duration: Duration(milliseconds: 1000),
//                 opacity: _textOpacity,
//                 child: Text(
//                   'Kebab Station',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: animation1.value,
//                       letterSpacing: 8,
//                       wordSpacing: 10),
//                 ),
//               ),
//             ],
//           ),
//           Center(
//             child: AnimatedOpacity(
//               duration: Duration(milliseconds: 3000),
//               curve: Curves.fastLinearToSlowEaseIn,
//               opacity: _containerOpacity,
//               child: AnimatedContainer(
//                   duration: Duration(milliseconds: 3000),
//                   curve: Curves.fastLinearToSlowEaseIn,
//                   height: _width / _containerSize,
//                   width: _width / _containerSize,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: Color.fromRGBO(255, 202, 6, 1),
//                     borderRadius: BorderRadius.circular(30),
//                     border: Border.all(color: Colors.white),
//                   ),
//                   child: Image.asset(
//                     'assets/images/l.jpg',
//                     fit: BoxFit.cover,
//                   )
//                   // child: Text(
//                   //   'YOUR APP\'S LOGO',
//                   // ),
//                   ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // class PageTransition extends PageRouteBuilder {
// //   final Widget page;

// //   PageTransition(this.page)
// //       : super(
// //           pageBuilder: (context, animation, anotherAnimation) => page,
// //           transitionDuration: Duration(milliseconds: 2000),
// //           transitionsBuilder: (context, animation, anotherAnimation, child) {
// //             animation = CurvedAnimation(
// //               curve: Curves.fastLinearToSlowEaseIn,
// //               parent: animation,
// //             );
// //             return Align(
// //               alignment: Alignment.bottomCenter,
// //               child: SizeTransition(
// //                 sizeFactor: animation,
// //                 child: page,
// //                 axisAlignment: 0,
// //               ),
// //             );
// //           },
// //         );
// // }
