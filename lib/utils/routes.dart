import 'package:flutter/material.dart';
import 'package:crud_mobile_flutter/model/category_model.dart';
import 'package:crud_mobile_flutter/model/product/product_model.dart';
import 'package:crud_mobile_flutter/screen/detail_product/detail_product_screen.dart';
import 'package:crud_mobile_flutter/screen/detail_product/form_product_screen.dart';
import 'package:crud_mobile_flutter/screen/main_screen/main_screen.dart';
import 'package:crud_mobile_flutter/screen/search/search_screen.dart';
import 'package:crud_mobile_flutter/screen/main_screen/splash_screen.dart';

Route? generatesRoutes(RouteSettings settings) {
  final args = settings.arguments;
  switch (settings.name) {
    case SplashScreen.routeName:
      return goto(settings, SplashScreen());
    case MainScreen.routeName:
      return goto(settings, MainScreen());
    case DetailProductScreen.routeName:
      return goto(
          settings,
          DetailProductScreen(
            model: args as ProductModel,
          ));
    case SearchScreen.routeName:
      return goto(
          settings,
          SearchScreen(
            query: args as String,
          ));

    case FormProductScreen.routeName:
      if (args is ProductModel) {
        return goto(
            settings,
            FormProductScreen(
              model: args,
            ));
      } else if (args is CategoryModel) {
        return goto(
            settings,
            FormProductScreen(
              categoryModel: args,
            ));
      } else {
        return goto(settings, FormProductScreen());
      }

    default:
      return goto(settings, MainScreen());
  }
}

MaterialPageRoute goto(RouteSettings settings, Widget builder) {
  return MaterialPageRoute(builder: (context) => builder, settings: settings);
}
