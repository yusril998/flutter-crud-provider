import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crud_mobile_flutter/screen/main_screen/main_screen.dart';
import 'package:crud_mobile_flutter/screen/main_screen/splash_screen.dart';
import 'package:crud_mobile_flutter/state/category_state.dart';
import 'package:crud_mobile_flutter/state/product_state.dart';
import 'package:crud_mobile_flutter/utils/routes.dart';

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
