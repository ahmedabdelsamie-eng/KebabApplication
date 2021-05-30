import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kabab/providers/auth.dart';
import 'package:kabab/providers/cart.dart';
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
import 'package:kabab/screens/splash_screen.dart';
import 'package:kabab/translations/codegen_loader.g.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

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
        ChangeNotifierProvider(create: (ctx) => Auth()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
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
          home: auth.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          // initialRoute: '/',
          routes: {
            // '/': (ctx) => AuthScreen(),
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
