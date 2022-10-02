import 'dart:async';

import 'package:amazon_clone/features/screens/homepage.dart';
import 'package:amazon_clone/providers/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash-screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    AppState provider = Provider.of<AppState>(context, listen: false);
    Future.delayed(Duration(milliseconds: 1500)).then((value) {
      // Timer(Duration(milliseconds: 1500), () {
      provider.localToken == null
          ? Navigator.pushReplacementNamed(context, '/auth-screen')
          : Navigator.pushReplacementNamed(context, '/home-screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                end: Alignment.topRight,
                begin: Alignment.bottomRight,
                colors: [Colors.purple.shade50, Colors.orange])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              child: Image.network(
                  "https://pngimg.com/uploads/amazon/amazon_PNG21.png"),
            ),
          ),
        ));
  }
}
