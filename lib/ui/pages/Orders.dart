import 'package:cached_network_image/cached_network_image.dart';
import 'package:f2k/repos/model/FinalOrder.dart';
import 'package:f2k/repos/model/Orders.dart';
import 'package:f2k/res/AppString.dart';
import 'package:f2k/services/HiveService.dart';
import 'package:f2k/ui/pages/BuildTextField.dart';
import 'package:f2k/ui/pages/ProductOrderBottomModal.dart';
import 'package:f2k/ui/pages/Sorry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import 'Product/ProductDetail.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<dynamic> orders = new List<dynamic>();
  TextEditingController _nameController;
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  List<double> priceList = new List();
  String userName;
  double totalPrice = 0.0;
  bool showProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getOrderFromHive();
    });
    FirebaseAuth.instance.currentUser().then((value) {
      setState(() {
        userName = value.displayName;
      });
    });
  }

  _getOrderFromHive() async {
    final openBox = await Hive.openBox("Cart");
    List<dynamic> temp = new List<dynamic>();
    List<double> tempPrices = new List();

    print("Loading from Hive");
    for (int i = 0; i < openBox.length; i++) {
      var box = openBox.getAt(i);
      temp.add(box);
      debugPrint(box.product.price);
      tempPrices
          .add(double.parse(box.orderCount) * double.parse(box.product.price));
    }
    double sum = tempPrices.fold(0, (p, c) => p + c);
    setState(() {
      orders = temp;
      priceList = tempPrices;
      totalPrice = sum;
    });
  }

  _deleteItem(int index) async {
    final openBox = await Hive.openBox("Cart");
    openBox.deleteAt(index);

    List<dynamic> temp = new List<dynamic>();
    List<double> tempPrices = new List();

    for (int i = 0; i < openBox.length; i++) {
      var box = openBox.getAt(i);

      temp.add(box);
      tempPrices
          .add(double.parse(box.orderCount) * double.parse(box.product.price));
    }
    double sum = tempPrices.fold(0, (p, c) => p + c);

    setState(() {
      orders = temp;
      priceList = tempPrices;
      totalPrice = sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: orders.length != 0
          ? BottomModal(
              orders: orders,
              totalPrice: totalPrice,
              getdata: _getOrderFromHive,
              userName: userName)
          : null,
      appBar: buildAppBar(),
      body: Container(
        child: orders.length != 0
            ? ListView.builder(
                itemCount: orders.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  dynamic order = orders[index];
                  return buildCard(width, context, order, index);
                })
            : ErrorSorry(msg: "You haven't added 🥑 to cart"),
      ),
    );
  }

  Padding buildCard(double width, BuildContext context, order, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
      child: Container(
        width: width,
        height: 150,
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (
                  BuildContext context,
                ) {
                  return ProductDetailScreen(product: order.product);
                }));
              },
              child: Hero(
                tag: order.product.sId,
                child: CachedNetworkImage(
                  imageUrl: order.product.imageurl,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: imageProvider),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      order.product.name,
                      style: TextStyle(
                          fontFamily: "Merriweather",
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          "Count: ",
                          style: TextStyle(
                            fontFamily: "Merriweather",
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(order.orderCount,
                            style: TextStyle(
                                fontFamily: "Merriweather",
                                fontSize: 18,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'Price',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: "Merriweather"),
                            children: <TextSpan>[
                          TextSpan(
                            text: "   ₹ ${priceList[index]}",
                            style: TextStyle(
                                fontFamily: "Merriweather",
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          )
                        ])),
                    Flexible(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: OutlineButton.icon(
                          focusColor: Colors.green[400],
                          hoverColor: Colors.green[400],
                          highlightedBorderColor: Colors.green[400],
                          onPressed: () => _deleteItem(index),
                          icon: Icon(Icons.delete_outline),
                          label: Text("Remove"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Orders",
        style: TextStyle(
            fontFamily: "Merriweather",
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
            fontSize: 24),
      ),
    );
  }
}
