import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:amazon_clone/features/services/auth_service.dart';
import 'package:amazon_clone/providers/state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../authentication.dart';
import '../../common/widget/allproducts.dart';
import '../../common/widget/sponsored.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home-screen';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    Future.delayed(Duration.zero).then((value) {
      print("get data called");
      getData(context);
    });
    Future.delayed(Duration.zero).then((value) {
      getCart(context);
    });
    Future.delayed(Duration.zero).then((value) {
      requestMicroPhonePermission(context);
    });
    super.initState();
  }

  getConnectivity() {
    print("connectivity called");
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        print("is internet connected---> $isDeviceConnected");
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() => isAlertSet = true);
        }
      },
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GestureDetector(
            onTap: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Log out'),
                content: const Text('Are you sure you want to log out?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final logpout = prefs.remove("token");
                      Navigator.pushReplacementNamed(context, "/auth-screen");
                    },
                    child: const Text('Yes'),
                  ),
                ],
              ),
            ),
            child: Image.network(
                "https://cdn.pixabay.com/photo/2014/04/03/11/56/avatar-312603_1280.png"),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/cart-screen");
              },
              child: Badge(
                child: Icon(
                  Icons.shopping_cart,
                  size: 30,
                ),
                badgeContent: Text(
                  "${provider.cartItems.length}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 40,
              color: Colors.grey[300],
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Icon(Icons.location_on)),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Delivering to Ronith - Bangalore-13")
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Amazon Shopping & services.",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                        color: Colors.grey[800]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "One stop app to shop all your needed electonics with huge discounts.",
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Sponsored",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Sponsored(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Products",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      Icon(
                        Icons.filter_list,
                        color: Colors.black45,
                        size: 30,
                      )
                    ],
                  ),
                  AllProducts(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showDialogBox() => Platform.isAndroid
      ? showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('No Connection'),
            content: const Text('Please check your internet connectivity'),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  Navigator.pop(context, 'Cancel');
                  setState(() => isAlertSet = false);
                  // getData(context);
                  // getCart(context);
                  isDeviceConnected =
                      await InternetConnectionChecker().hasConnection;
                  if (!isDeviceConnected && isAlertSet == false) {
                    showDialogBox();
                    setState(() => isAlertSet = true);
                  }
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        )
      : showCupertinoDialog<String>(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text('No Connection'),
            content: const Text('Please check your internet connectivity'),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  Navigator.pop(context, 'Cancel');
                  setState(() => isAlertSet = false);
                  // getData(context);
                  // getCart(context);
                  isDeviceConnected =
                      await InternetConnectionChecker().hasConnection;
                  if (!isDeviceConnected && isAlertSet == false) {
                    showDialogBox();
                    setState(() => isAlertSet = true);
                  }
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        );
}
