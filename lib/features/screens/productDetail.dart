// ignore_for_file: implementation_imports, prefer_const_constructors, prefer_is_empty, unnecessary_import

import 'package:amazon_clone/common/widget/custom_button.dart';
import 'package:amazon_clone/common/widget/productDetailsSkeleton.dart';
import 'package:amazon_clone/common/widget/skeleton.dart';
import 'package:amazon_clone/features/services/auth_service.dart';
import 'package:amazon_clone/providers/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetail extends StatefulWidget {
  // const ProductDetail({Key? key}) : super(key: key);
  static const String routeName = '/detail-screen';
  final String id;
  ProductDetail({required this.id});
  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      loadProductDetail(widget.id, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,##,000');

    AppState provider = Provider.of<AppState>(context);
    return Scaffold(
      body: SafeArea(
          left: false,
          right: false,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      provider.productDetailsloading = true;
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  IconButton(
                    onPressed: () async {
                      final url = "https://amazon.in";
                      await Share.share(
                          "Check out this ${provider.items[0].name} which has a dicount of ${provider.items[0].discount}% available only on this app $url ");
                    },
                    icon: Icon(Icons.share),
                  )
                ],
              ),
              provider.productDetailsloading
                  ? ProductDetailsSkeleton()
                  : provider.items.length != 0
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: provider.items.length,
                          itemBuilder: ((context, index) {
                            return Column(
                              children: [
                                Stack(
                                  children: [
                                    Image.network(
                                      provider.items[index].image,
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 10,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${provider.items[index].discount} %",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 20,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade50,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            provider.items[index].inStock
                                                ? "In Stock"
                                                : "Out of stock",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: provider
                                                        .items[index].inStock
                                                    ? Colors.green
                                                    : Colors.red),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${provider.items[index].name}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${provider.items[index].description}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Ratings"),
                                          Row(
                                            children: [
                                              for (int i = 0;
                                                  i <
                                                      provider
                                                          .items[index].ratings;
                                                  i++)
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                  size: 17,
                                                )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Original price: ₹${formatter.format(provider.items[index].originalPrice)}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Discounted price: ₹${formatter.format(provider.items[index].discountedPrice)}",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      CustomButton(
                                          text: "Add to cart",
                                          onTap: () {
                                            addToCart(provider.items[index].id,
                                                context);
                                          }),
                                      // ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 50,
                                        child: ElevatedButton(
                                            child: Text("Buy now"),
                                            onPressed:
                                                provider.items[index].inStock
                                                    ? () {
                                                        Navigator.pushNamed(
                                                            context,
                                                            "/payment-screen");
                                                      }
                                                    : null),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          }),
                        )
                      : Container(),
            ],
          )),
    );
  }
}
