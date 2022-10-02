import 'dart:async';
// import 'dart:developer';
import 'dart:io';

import 'package:amazon_clone/authentication.dart';
import 'package:amazon_clone/constants/global_variables.dart';
// import 'package:amazon_clone/features/screens/auth_screen.dart';
// import 'package:amazon_clone/features/screens/homepage.dart';
// import 'package:amazon_clone/features/screens/payment_screen.dart';
import 'package:amazon_clone/features/screens/splash_screen.dart';
// import 'package:amazon_clone/features/services/auth_service.dart';
import 'package:amazon_clone/providers/state.dart';
import 'package:amazon_clone/router.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "high_importanceChannel", "High importance notification",
    importance: Importance.high, playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("a bg message : ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isAuthenticated = await authenticate();
  if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
  }
  if (isAuthenticated) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AppState(),
          )
        ],
        child: MyApp(),
      ),
    );
  }
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
    // Future.delayed(Duration.zero).then((value) {
    //   getAuthentication(context);
    // });

    Future.delayed(Duration.zero).then((value) {
      getLocalToken(context);
    });

    if (Platform.isAndroid) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          print("called here");
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  channelDescription: channel.description,
                  color: Colors.blue,
                  playSound: true,
                  icon: "@mipmap/ic_launcher"),
            ),
          );
        }
      });
    }
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
    if (Platform.isAndroid) {
      FirebaseMessaging.onMessageOpenedApp.listen(
        (RemoteMessage message) {
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;
          if (notification != null && android != null) {
            Navigator.pushNamed(context, "/home");
          }
        },
      );
    }

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
    );
  }
}
