import 'dart:developer';

import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/screens/auth_screen.dart';
import 'package:amazon_clone/features/screens/homepage.dart';
import 'package:amazon_clone/features/screens/payment_screen.dart';
import 'package:amazon_clone/features/screens/splash_screen.dart';
import 'package:amazon_clone/features/services/auth_service.dart';
import 'package:amazon_clone/providers/state.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AppState(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? change;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      getLocalToken(context);
    });
  }

  void getLocalToken(context) async {
    AppState provider = Provider.of<AppState>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    String? tokenInLocalStorage = prefs.getString("token");
    provider.localToken = tokenInLocalStorage;
    print(tokenInLocalStorage);
  }

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: GlobalVariables.secondaryColor),
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: SplashScreen(),
      // home: PaymentScreen(),
    );
  }
}
