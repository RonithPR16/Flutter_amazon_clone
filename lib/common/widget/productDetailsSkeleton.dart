import 'package:amazon_clone/common/widget/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProductDetailsSkeleton extends StatelessWidget {
  const ProductDetailsSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          Skeleton(
            width: 350,
            height: 350,
          ),
          Positioned(
              top: 5,
              left: 5,
              child: Skeleton(
                height: 30,
                width: 50,
              )),
          Positioned(
              top: 5,
              right: 5,
              child: Skeleton(
                height: 30,
                width: 70,
              ))
        ]),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Skeleton(
            height: 30,
            width: double.infinity,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Skeleton(
            height: 30,
            width: double.infinity,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Skeleton(
            height: 30,
            width: double.infinity,
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Skeleton(
            width: double.infinity,
            height: 60,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Skeleton(
            width: double.infinity,
            height: 60,
          ),
        ),
      ],
    );
  }
}
