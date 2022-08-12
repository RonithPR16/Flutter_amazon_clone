// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:amazon_clone/common/widget/snackbar.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/models/cartModal.dart';
import 'package:amazon_clone/models/signedinUser.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/productModal.dart';
import '../../providers/state.dart';

signUpUser({
  required BuildContext context,
  required String email,
  required String username,
  required String fullname,
  required String password,
  required bool isLoggedIn,
}) async {
  try {
    User user = User(
      username: username,
      fullname: fullname,
      email: email,
      password: password,
      id: "",
      token: '',
    );
    final response = await http.post(Uri.parse('$uri/user'),
        body: user.toJson(),
        headers: <String, String>{'Content-type': 'application/json'});
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      showSnackBar(context, "Account created", true);
      await Future.delayed(Duration(milliseconds: 500));
      Navigator.pushNamed(context, '/auth-screen',
          arguments: {isLoggedIn: true});
    }
  } catch (e) {
    print(e);
  }
}

userSignIn({
  required BuildContext context,
  required String username,
  required String password,
}) async {
  String tokens;

  try {
    SignInUser signInUser = SignInUser(username: username, password: password);
    final response = await http.post(Uri.parse('$uri/login'),
        body: jsonEncode({"username": username, "password": password}),
        headers: <String, String>{'Content-type': 'application/json'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      tokens = jsonDecode(response.body)["token"];
      Provider.of<AppState>(context, listen: false).setUser(tokens);
      await prefs.setString("token", jsonDecode(response.body)["token"]);
      showSnackBar(context, "Signed in successfully", true);
      await Future.delayed(Duration(milliseconds: 500));
      Navigator.pushNamed(context, '/home-screen');
      return tokens;
    } else {
      print(response.body);
    }
  } catch (e) {
    print(e);
  }
}

getData(context) async {
  AppState provider = Provider.of(context, listen: false);
  List<ProductModal> products = [];
  try {
    final url = Uri.parse("https://backend.sadhik.repl.co/products");
    final response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> data = jsonDecode(response.body);
      data.forEach((element) {
        ProductModal productItem = ProductModal.fromJson(element);
        products.add(productItem);
        provider.getProducts(products);
      });
    }
  } catch (e) {}
}

loadProductDetail(id, context) async {
  print("called,$id");
  AppState provider = Provider.of<AppState>(context, listen: false);
  try {
    List<ProductModal> value = [];
    print("this is id ---> $id");
    final url = Uri.parse("https://backend.sadhik.repl.co/products/$id");
    final response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      print(response.body);
      Map<String, dynamic> data = jsonDecode(response.body);
      ProductModal items = ProductModal.fromJson(data);
      value.add(items);
      provider.getDetail(value);
      provider.productDetailsloading = false;
    }
  } catch (e) {}
}

addToCart(id, context) async {
  AppState provider = Provider.of<AppState>(context, listen: false);
  String? token = provider.localToken;
  var body = jsonEncode({"_id": id, "quantity": 1, "isActive": true});
  try {
    print("this is id,$id");
    List<CartModal> items = [];
    final url = Uri.parse("https://backend.sadhik.repl.co/cart");
    final response = await http.post(url, body: body, headers: {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: token!
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(jsonDecode(response.body));
      showSnackBar(context, "Item added to cart", true);
    }
  } catch (e) {
    print(e);
  }
}

getCart(context) async {
  List<CartModal> cartProduct = [];
  AppState provider = Provider.of<AppState>(context, listen: false);
  String? token = provider.localToken;
  print("here it is,$token");
  print("getCart called");
  try {
    print("getCart called");

    final url = Uri.parse("https://backend.sadhik.repl.co/cart");
    final response =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token!});
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      print(jsonDecode(response.body)["activeProducts"]);
      // print(jsonDecode(response.body)["activeProducts"].length);
      List<dynamic> data = jsonDecode(response.body)["activeProducts"];
      data.forEach((element) {
        CartModal item = CartModal.fromJson(element);
        cartProduct.add(item);
        provider.getCartProduct(cartProduct);
        provider.loading = false;
      });
    }
  } catch (e) {}
}

increaseCartItem(id, quantity, context) async {
  AppState provider = Provider.of<AppState>(context, listen: false);
  String? token = provider.localToken;
  var body =
      jsonEncode({"_id": id, "quantity": quantity + 1, "isActive": true});
  print(id);
  try {
    final url = Uri.parse("https://backend.sadhik.repl.co/cart");
    final response = await http.post(url, body: body, headers: {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: token!
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      print(response.body);
      getCart(context);
    } else {
      print(response.body);
    }
  } catch (e) {
    print(e);
  }
}

decreaseCartItem(id, quantity, context) async {
  print("decreaseCartItem called");

  AppState provider = Provider.of<AppState>(context, listen: false);
  String? token = provider.localToken;
  var body =
      jsonEncode({"_id": id, "quantity": quantity - 1, "isActive": true});
  try {
    final url = Uri.parse("https://backend.sadhik.repl.co/cart");
    final response = await http.post(url, body: body, headers: {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: token!
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      print(response.body);
      getCart(context);
    }
  } catch (e) {
    print(e);
  }
}

deleteCartItem(id, quantity, context) async {
  AppState provider = Provider.of<AppState>(context, listen: false);
  String? token = provider.localToken;
  var body = jsonEncode({"_id": id, "quantity": quantity, "isActive": false});
  try {
    final url = Uri.parse("https://backend.sadhik.repl.co/cart");
    final response = await http.post(url, body: body, headers: {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: token!
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      print(response.body);
      getCart(context);
    }
  } catch (e) {
    print(e);
  }
}

void requestMicroPhonePermission(context) async {
  print("called");
  var status = await Permission.microphone.status;

  if (status.isGranted) {
    showSnackBar(context, "Microphone permission  granted", true);
    print("here");
    print("micrpophone permission granted");
  } else if (status.isDenied) {
    var res = await Permission.microphone.request();

    if (await Permission.microphone.request().isGranted) {
      print("permission is granted at 2nd level");
      showSnackBar(context, "Microphone permission  granted", true);
    }
    if (Platform.isAndroid) {
      if (res == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      }
    }
  } else {
    openAppSettings();
  }
}
