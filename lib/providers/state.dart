import 'package:amazon_clone/features/services/auth_service.dart';
import 'package:amazon_clone/models/cartModal.dart';
import 'package:amazon_clone/models/productModal.dart';
import 'package:amazon_clone/models/signedinUser.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  String validToken = "";
  bool loading = true;
  bool productDetailsloading = true;

  List<ProductModal> products = [];
  void setUser(String token) {
    validToken = token;
    notifyListeners();
  }

  void getProducts(List<ProductModal> product) {
    products = product;
    notifyListeners();
  }

  String? localToken = "";
  List<ProductModal> items = [];

  void getDetail(List<ProductModal> item) {
    items = item;
    notifyListeners();
  }

  List<CartModal> cartItems = [];
  void getCartProduct(List<CartModal> cartItem) {
    cartItems = cartItem;
    notifyListeners();
  }
}
