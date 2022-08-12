import 'package:amazon_clone/features/screens/cart_screen.dart';
import 'package:amazon_clone/features/screens/homepage.dart';
import 'package:amazon_clone/features/screens/invoice_screen.dart';
import 'package:amazon_clone/features/screens/payment_screen.dart';
import 'package:amazon_clone/features/screens/productDetail.dart';
import 'package:amazon_clone/features/screens/signup.dart';
import 'package:amazon_clone/features/screens/splash_screen.dart';
import "package:flutter/material.dart";

import 'features/screens/auth_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case SignUp.routeName:
      return MaterialPageRoute(builder: (_) => SignUp());
    case HomePage.routeName:
      return MaterialPageRoute(builder: (_) => HomePage());
    case ProductDetail.routeName:
      final args = routeSettings.arguments as ProductDetail;
      return MaterialPageRoute(builder: (_) => ProductDetail(id: args.id));
    case CartScreen.routeName:
      return MaterialPageRoute(builder: (_) => CartScreen());
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (_) => SplashScreen());
    case PaymentScreen.routeName:
      return MaterialPageRoute(builder: (_) => PaymentScreen());
    case InvoiceScreen.routeName:
      return MaterialPageRoute(builder: (_) => InvoiceScreen());
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Scaffold(
          body: Center(
            child: Text("This page does not exist"),
          ),
        ),
      );
  }
}
