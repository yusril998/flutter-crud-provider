import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_mobile_flutter/screen/main_screen.dart';
import 'package:test_mobile_flutter/screen/splash_screen.dart';
import 'package:test_mobile_flutter/state/category_state.dart';
import 'package:test_mobile_flutter/state/product_state.dart';
import 'package:test_mobile_flutter/utils/routes.dart';

void main() async {
  HttpOverrides.global = new MyHttpoverrides();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyHttpoverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => ProductState()),
          ChangeNotifierProvider(create: (ctx) => CategoryState()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Monsterrat',
            primaryColor: Colors.green,
            colorScheme:
                ColorScheme.fromSwatch().copyWith(primary: Colors.green[700]),
          ),
          home: SplashScreen(),
          initialRoute: '/',
          onGenerateRoute: (settings) => generatesRoutes(settings),
          routes: {
            MainScreen.routeName: (ctx) => MainScreen(),
          },
        ));
  }
}
