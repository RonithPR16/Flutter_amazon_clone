// To parse this JSON data, do
//
//     final cartModal = cartModalFromJson(jsonString);

import 'dart:convert';

List<CartModal> cartModalFromJson(String str) =>
    List<CartModal>.from(json.decode(str).map((x) => CartModal.fromJson(x)));

String cartModalToJson(List<CartModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModal {
  CartModal({
    required this.productId,
    required this.quantity,
    required this.isActive,
    required this.id,
    required this.createdAt,
  });

  ProductId productId;
  int quantity;
  bool isActive;
  String id;
  DateTime createdAt;

  factory CartModal.fromJson(Map<String, dynamic> json) => CartModal(
        productId: ProductId.fromJson(json["productId"]),
        quantity: json["quantity"],
        isActive: json["isActive"],
        id: json["_id"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "productId": productId.toJson(),
        "quantity": quantity,
        "isActive": isActive,
        "_id": id,
        "created_at": createdAt.toIso8601String(),
      };
}

class ProductId {
  ProductId({
    required this.id,
    required this.name,
    required this.image,
    required this.originalPrice,
    required this.discountedPrice,
    required this.brand,
    required this.ratings,
    required this.discount,
    required this.totalPurchase,
    required this.inStock,
    required this.fastDelivery,
    required this.yogaAssured,
    required this.availableQty,
  });

  String id;
  String name;
  String image;
  int originalPrice;
  int discountedPrice;
  String brand;
  int ratings;
  int discount;
  int totalPurchase;
  bool inStock;
  bool fastDelivery;
  bool yogaAssured;
  int availableQty;

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        originalPrice: json["originalPrice"],
        discountedPrice: json["discountedPrice"],
        brand: json["brand"],
        ratings: json["ratings"],
        discount: json["discount"],
        totalPurchase: json["totalPurchase"],
        inStock: json["inStock"],
        fastDelivery: json["fastDelivery"],
        yogaAssured: json["yogaAssured"],
        availableQty: json["availableQty"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "originalPrice": originalPrice,
        "discountedPrice": discountedPrice,
        "brand": brand,
        "ratings": ratings,
        "discount": discount,
        "totalPurchase": totalPurchase,
        "inStock": inStock,
        "fastDelivery": fastDelivery,
        "yogaAssured": yogaAssured,
        "availableQty": availableQty,
      };
}
