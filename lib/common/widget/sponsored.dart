import 'package:amazon_clone/common/widget/skeleton.dart';
import 'package:amazon_clone/features/screens/productDetail.dart';
import 'package:amazon_clone/providers/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class Sponsored extends StatelessWidget {
  const Sponsored({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of(context);
    return provider.products.isNotEmpty
        ? Row(
            children: provider.products.sublist(0, 8).map((e) {
              return GestureDetector(
                onTap: () {
                  // print(e.id);
                  Navigator.pushNamed(context, "/detail-screen",
                      arguments: ProductDetail(id: e.id));
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      child: Image.network(
                        "${e.image}",
                        width: 150,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        "${e.name}",
                        style: TextStyle(fontSize: 10),
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          )
        : Row(
            children: [
              Skeleton(
                width: 150,
                height: 150,
              ),
              SizedBox(
                width: 10,
              ),
              Skeleton(
                width: 150,
                height: 150,
              ),
              SizedBox(
                width: 10,
              ),
              Skeleton(
                width: 150,
                height: 150,
              ),
              SizedBox(
                width: 10,
              ),
              Skeleton(
                width: 150,
                height: 150,
              ),
            ],
          );
  }
}
