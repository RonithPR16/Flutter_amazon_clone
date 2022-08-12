// To parse this JSON data, do
//
//     final productModal = productModalFromJson(jsonString);

import 'dart:convert';

ProductModal productModalFromJson(String str) =>
    ProductModal.fromJson(json.decode(str));

String productModalToJson(ProductModal data) => json.encode(data.toJson());

class ProductModal {
  ProductModal({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.originalPrice,
    required this.discountedPrice,
    required this.category,
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
  String description;
  int originalPrice;
  int discountedPrice;
  String category;
  String brand;
  int ratings;
  int discount;
  int totalPurchase;
  bool inStock;
  bool fastDelivery;
  bool yogaAssured;
  int availableQty;

  factory ProductModal.fromJson(Map<String, dynamic> json) => ProductModal(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        originalPrice: json["originalPrice"],
        discountedPrice: json["discountedPrice"],
        category: json["category"],
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
        "description": description,
        "originalPrice": originalPrice,
        "discountedPrice": discountedPrice,
        "category": category,
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
