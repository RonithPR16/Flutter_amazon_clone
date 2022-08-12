import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NoItemsInCart extends StatelessWidget {
  const NoItemsInCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height) - 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("No items in cart"),
          Text("Browse items"),
        ],
      ),
    );
  }
}
