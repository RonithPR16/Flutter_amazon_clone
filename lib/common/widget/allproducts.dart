// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations
import 'package:amazon_clone/common/widget/skeleton.dart';
import 'package:amazon_clone/features/screens/productDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
// ignore: unnecessary_import
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/state.dart';

class AllProducts extends StatelessWidget {
  var formatter = NumberFormat('#,##,000');
  // const AllProducts({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);
    return provider.products.isEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: 20,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: double.infinity,
                  child: Skeleton(
                    width: 160,
                    height: 180,
                  ),
                  //   ],
                  // ),
                ),
              );
            },
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: provider.products.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {
                  print(provider.products[index].id);
                  Navigator.pushNamed(context, "/detail-screen",
                      arguments:
                          ProductDetail(id: provider.products[index].id));
                },
                child: Container(
                  // width: 40,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Image.network(
                        "${provider.products[index].image}",
                        width: 180,
                        height: 180,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            child: Text(
                              "${provider.products[index].name}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Container(
                            child: Text(
                              "${provider.products[index].brand}",
                              style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "₹${formatter.format(provider.products[index].discountedPrice)}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              Container(
                                width: 90,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Text(
                                    "(${provider.products[index].discount}% discount)",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              for (int i = 0;
                                  i < provider.products[index].ratings;
                                  i++)
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 17,
                                )
                            ],
                          ),
                          Text(
                            provider.products[index].fastDelivery
                                ? "Get it by today"
                                : "Get it by tomorrow",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
  }
}
