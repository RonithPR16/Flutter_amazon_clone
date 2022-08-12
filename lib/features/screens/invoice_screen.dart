// ignore_for_file: prefer_const_constructors

import 'package:amazon_clone/common/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lottie/lottie.dart';

import '../../main.dart';

class InvoiceScreen extends StatelessWidget {
  static const String routeName = '/invoice-screen';
  const InvoiceScreen({Key? key}) : super(key: key);

  void sendNotification(context) {
    flutterLocalNotificationsPlugin.show(
      0,
      "Amazon",
      "Your order has been placed successfully",
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            channelDescription: channel.description,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/ic_launcher'),
      ),
    );
    Navigator.pushReplacementNamed(context, "/home-screen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Checkout",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Thank you!",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.orange.shade300),
                    child: Text("Download invoice"),
                    onPressed: () {})
              ],
            )),
        // ),
        bottomSheet: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
          child: BottomAppBar(
            color: Colors.grey.shade300,
            child: Container(
              height: 350,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: 200,
                      height: 150,
                      child: Lottie.network(
                          "https://assets7.lottiefiles.com/packages/lf20_hyu7syrj.json"),
                    ),
                    Text(
                      "Thankyou for purchasing",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Your order will be delivered in the next 2 to 3 days",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      text: "Continue shopping",
                      onTap: () {
                        sendNotification(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
