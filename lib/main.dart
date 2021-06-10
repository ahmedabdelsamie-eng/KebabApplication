import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kabab/providers/auth.dart';
import 'package:kabab/providers/cart.dart';
import 'package:kabab/providers/notification.dart';
import 'package:kabab/screens/auth_screen.dart';
import 'package:kabab/screens/cart_screen1.dart';
import 'package:kabab/screens/cart_screen2.dart';
import 'package:kabab/screens/home_screen.dart';
import 'package:kabab/screens/language_screen.dart';
import 'package:kabab/screens/locations_screen.dart';
import 'package:kabab/screens/notifications_screen.dart';
import 'package:kabab/screens/orders_screen.dart';
import 'package:kabab/screens/section_item_details_screen.dart';
import 'package:kabab/screens/single_category_screen.dart';
import 'package:kabab/translations/codegen_loader.g.dart';
import 'package:provider/provider.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      startLocale: Locale('ar'),
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Notificationy(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => GetMaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.amber,
            accentColor: Colors.white,
            //  accentColorBrightness: Brightness.light
          ),
          // '/': MyCustomSplashScreen(),
          initialRoute: '/',
          routes: {
            '/': (ctx) => MyCustomSplashScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            SingleCategoryScreen.routeName: (ctx) => SingleCategoryScreen(),
            SectionItemDetailsScreen.routeName: (ctx) =>
                SectionItemDetailsScreen(),
            CartScreen1.routeName: (ctx) => CartScreen1(),
            CartScreen2.routeName: (ctx) => CartScreen2(),
            LanguageScreen.routeName: (ctx) => LanguageScreen(),
            LocationsScreen.routeName: (ctx) => LocationsScreen(),
            NotificationsScreen.routeName: (ctx) => NotificationsScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
          },
        ),
      ),
    );
  }
}
///////////////

class MyCustomSplashScreen extends StatefulWidget {
  static const routeName = '/custom-splash';
  @override
  _MyCustomSplashScreenState createState() => _MyCustomSplashScreenState();
}

class _MyCustomSplashScreenState extends State<MyCustomSplashScreen>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  AnimationController _controller;
  Animation<double> animation1;
  List<String> notList = [];
  Timer a;
  Timer b;
  Timer c;
  var init = true;
  @override
  void didChangeDependencies() {
    if (init) {
      _controller =
          AnimationController(vsync: this, duration: Duration(seconds: 1));

      animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
          parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
        ..addListener(() {
          setState(() {
            _textOpacity = 1.0;
          });
        });

      _controller.forward();

      a = Timer(Duration(seconds: 2), () {
        setState(() {
          _fontSize = 1.06;
        });
      });

      b = Timer(Duration(seconds: 2), () {
        setState(() {
          _containerSize = 2;
          _containerOpacity = 1;
        });
      });
      c = Timer(Duration(seconds: 4), () {
        setState(() {
          Provider.of<Auth>(context, listen: false)
              .tryAutoLogin()
              .then((value) {
            print(value);
            return value == false
                ? Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => AuthScreen(),
                    ),
                  )
                : Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => HomeScreen(),
                    ),
                  );
          });
        });
      });

      ///////////////about show notification which sent
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                  color: Colors.amber,
                  subText: 'have a nice day.',
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
              ));

          Get.offAll(() => NotificationsScreen(), arguments: {
            'title': notification.title,
            'body': notification.body,
            'date': message.sentTime.toString()
          });
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        RemoteNotification notification = message.notification;
        AndroidNotification android = message.notification?.android;
        if (notification != null && android != null) {
          print('bbbbbbbbbbbbbbbbbbbb');
          // Timer(Duration(seconds: 5), () {
          Get.offAll(() => NotificationsScreen(), arguments: {
            'title': notification.title,
            'body': notification.body,
            'date': message.sentTime.toString()
          }); // });
        }
      });
    }
    init = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    a.cancel();
    b.cancel();
    c.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 202, 6, 1),
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                  duration: Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: _height / _fontSize),
              AnimatedOpacity(
                duration: Duration(milliseconds: 1000),
                opacity: _textOpacity,
                child: Text(
                  'Kebab Station',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: animation1.value,
                      letterSpacing: 8,
                      wordSpacing: 10),
                ),
              ),
            ],
          ),
          Center(
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 3000),
              curve: Curves.fastLinearToSlowEaseIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                  duration: Duration(milliseconds: 3000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: _width / _containerSize,
                  width: _width / _containerSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 202, 6, 1),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Image.asset(
                    'assets/images/l.jpg',
                    fit: BoxFit.cover,
                  )
                  // child: Text(
                  //   'YOUR APP\'S LOGO',
                  // ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
/////////////////////

// class MyNot extends StatefulWidget {
//   static const routeName = '/custom-splash';
//   @override
//   _MyNot createState() => _MyNot();
// }

// class _MyNot extends State<MyNot> {
//   var init = true;
//   @override
//   void didChangeDependencies() {
//     if (init) {
//       ///////////////about show notification which sent
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         RemoteNotification notification = message.notification;
//         AndroidNotification android = message.notification?.android;
//         if (notification != null && android != null) {
//           flutterLocalNotificationsPlugin.show(
//               notification.hashCode,
//               notification.title,
//               notification.body,
//               NotificationDetails(
//                 android: AndroidNotificationDetails(
//                   channel.id,
//                   channel.name,
//                   channel.description,
//                   color: Colors.amber,
//                   subText: 'have a nice day.',
//                   playSound: true,
//                   icon: '@mipmap/ic_launcher',
//                 ),
//               ));
//           Get.offAll(() => NotificationsScreen(), arguments: {
//             'title': notification.title,
//             'body': notification.body,
//             'date': message.sentTime.toString()
//           });
//         }
//       });

//       FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//         RemoteNotification notification = message.notification;
//         AndroidNotification android = message.notification?.android;
//         if (notification != null && android != null) {
//           print('bbbbbbbbbbbbbbbbbbbb');
//           Get.offAll(() => NotificationsScreen(), arguments: {
//             'title': notification.title,
//             'body': notification.body,
//             'date': message.sentTime.toString()
//           });
//         }
//       });
//     }
//     init = false;
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Text('test');
//   }
// }
