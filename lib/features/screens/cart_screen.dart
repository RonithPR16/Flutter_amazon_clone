// ignore_for_file: prefer_const_constructors, implementation_imports, unused_import, unnecessary_import

import 'package:amazon_clone/common/widget/noItemsInCart.dart';
import 'package:amazon_clone/common/widget/skeleton.dart';
import 'package:amazon_clone/features/services/auth_service.dart';
import 'package:amazon_clone/providers/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../common/widget/snackbar.dart';
import '../../constants/global_variables.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart-screen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      getCart(context);
    });
  }

  Future refresh() {
    return getCart(context);
  }

  // void requestMicroPhonePermission() async {
  //   var status = await Permission.microphone.status;
  //   print("line 40 ${status}");
  //   if (status == PermissionStatus.granted) {
  //     showSnackBar(context, "Microphone permission  granted", true);
  //   } else if (status == PermissionStatus.denied) {
  //     await Permission.microphone.request();
  //     print(status);
  //     if (status == PermissionStatus.granted) {
  //       showSnackBar(context, "Microphone permission  granted", false);
  //     } else if (status == PermissionStatus.denied) {
  //       showSnackBar(context, "Microphone permission  denied", false);
  //     } else if (status == PermissionStatus.permanentlyDenied) {
  //       await openAppSettings();
  //     }
  //   } else {
  //     await openAppSettings();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);
    var controller = TextEditingController();
    var formatter = NumberFormat('#,##,000');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              filled: true,
              fillColor: Colors.grey[300],
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                },
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black87,
                ),
              ),
              hintText: 'Search...',
              hintStyle: TextStyle(),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              requestMicroPhonePermission(context);
            },
            child: Container(
              margin: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.mic,
                color: Colors.black,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView(
          children: [
            Container(
              height: 40,
              color: Colors.grey[300],
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Icon(Icons.location_on)),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Delivering to Ronith - Bangalore-13 ")
                ],
              ),
            ),
            provider.loading

                // provider.cartItems.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(),
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Column(
                                children: [
                                  Skeleton(
                                    width: 110,
                                    height: 110,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Skeleton(
                                        width: 40,
                                        height: 40,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Skeleton(
                                        width: 40,
                                        height: 40,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Skeleton(
                                        width: 40,
                                        height: 40,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    Skeleton(
                                      width: 200,
                                      height: 30,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Skeleton(
                                      width: 200,
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Skeleton(
                                      width: 200,
                                      height: 20,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        }),
                  )
                : provider.cartItems.length == 0
                    ? NoItemsInCart()
                    : ListView.separated(
                        separatorBuilder: (context, index) => Divider(),
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: provider.cartItems.length,
                        itemBuilder: ((context, index) {
                          return Slidable(
                            key: UniqueKey(),
                            startActionPane: ActionPane(
                                dismissible: DismissiblePane(
                                  onDismissed: () {
                                    deleteCartItem(
                                        provider.cartItems[index].productId.id,
                                        provider.cartItems[index].quantity,
                                        context);
                                  },
                                ),
                                motion: const DrawerMotion(),
                                children: [
                                  SlidableAction(
                                    label: "Delete",
                                    icon: Icons.delete,
                                    backgroundColor: Colors.red,
                                    onPressed: (ctx) {
                                      deleteCartItem(
                                          provider
                                              .cartItems[index].productId.id,
                                          provider.cartItems[index].quantity,
                                          context);
                                    },
                                  ),
                                  // SlidableAction(
                                  //   label: "Share",
                                  //   icon: Icons.share,
                                  //   backgroundColor: Colors.blue,
                                  //   onPressed: (context) {},
                                  // )
                                ]),
                            child: Container(
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 150,
                                        child: Image.network(provider
                                            .cartItems[index].productId.image),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 50,
                                            child: OutlinedButton(
                                              onPressed: () {},
                                              child: provider.cartItems[index]
                                                          .quantity <=
                                                      1
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        deleteCartItem(
                                                            provider
                                                                .cartItems[
                                                                    index]
                                                                .productId
                                                                .id,
                                                            provider
                                                                .cartItems[
                                                                    index]
                                                                .quantity,
                                                            context);
                                                      },
                                                      child: Container(
                                                        child: Icon(
                                                          Icons.delete,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    )
                                                  : GestureDetector(
                                                      onTap: () {
                                                        print(
                                                            "Iconbutton called");
                                                        decreaseCartItem(
                                                            provider
                                                                .cartItems[
                                                                    index]
                                                                .productId
                                                                .id,
                                                            provider
                                                                .cartItems[
                                                                    index]
                                                                .quantity,
                                                            context);
                                                      },
                                                      child: Icon(
                                                        Icons.remove,
                                                        size: 20,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              "${provider.cartItems[index].quantity}"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 50,
                                            child: OutlinedButton(
                                              onPressed: () {
                                                print("Pressed");
                                                increaseCartItem(
                                                    provider.cartItems[index]
                                                        .productId.id,
                                                    provider.cartItems[index]
                                                        .quantity,
                                                    context);
                                              },
                                              child: Icon(
                                                Icons.add,
                                                size: 20,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 240,
                                        child: Text(
                                          "${provider.cartItems[index].productId.name}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20),
                                        ),
                                      ),
                                      Text(
                                          "₹ ${formatter.format(provider.cartItems[index].productId.discountedPrice)}"),
                                      Text(provider.cartItems[index].productId
                                              .inStock
                                          ? "In Stock"
                                          : "Out of stock"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }))
            // : Text("No Items in Cart")
          ],
        ),
      ),
      bottomNavigationBar: provider.cartItems.length != 0
          ? ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
              child: BottomAppBar(
                color: Colors.grey.shade300,
                child: Container(
                  height: 100,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Subtotal: ₹${provider.cartItems.length == 0 ? "0" : formatter.format(provider.cartItems.map((e) => e.productId.discountedPrice * e.quantity).reduce((value, element) => value + element))}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 40,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, "/payment-screen");
                                },
                                child: Text("checkout")))
                      ],
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
