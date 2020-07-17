import 'package:f2k/repos/model/FinalOrder.dart';
import 'package:f2k/repos/model/Orders.dart';
import 'package:f2k/res/AppString.dart';
import 'package:f2k/ui/pages/BuildTextField.dart';
import 'package:f2k/ui/pages/Sorry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

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
      tempPrices.add(double.parse(box.orderCount) *
          double.parse(box.product.price.split("\$")[1]));
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
      tempPrices.add(double.parse(box.orderCount) *
          double.parse(box.product.price.split("\$")[1]));
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
    final height = MediaQuery.of(context).size.height;
    _nameController = new TextEditingController(text: userName);

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: orders.length != 0
          ? buildFloatingActionButton(context, height, width)
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
        child: InkWell(
          onTap: () {
            Navigator.push(context, CupertinoPageRoute(builder: (
              BuildContext context,
            ) {
              return ProductDetailScreen(product: order.product);
            }));
          },
          child: Row(
            children: <Widget>[
              Hero(
                tag: order.product.sId,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://images.unsplash.com/photo-1550081699-79c1c2e48a77?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
                          )),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Padding(
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
              )
            ],
          ),
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

  FloatingActionButton buildFloatingActionButton(
      BuildContext context, double height, double width) {
    return FloatingActionButton.extended(
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            enableDrag: true,
            context: context,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            builder: (context) {
              return Container(
                height: height * 0.8,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 5,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      BuildTextField(
                          width: width,
                          controller: _nameController,
                          icon: Icons.person_outline,
                          hintText: "Name",
                          textInputType: TextInputType.text),
                      BuildTextField(
                          width: width,
                          controller: _phoneController,
                          icon: Icons.phone,
                          hintText: "Phone Number",
                          textInputType: TextInputType.phone),
                      BuildTextField(
                          width: width,
                          controller: _addressController,
                          icon: Icons.home,
                          hintText: "Address",
                          textInputType: TextInputType.multiline),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                          text: TextSpan(
                              text: 'Net Price',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: "Merriweather"),
                              children: <TextSpan>[
                            TextSpan(
                              text: "   ₹ ${totalPrice}",
                              style: TextStyle(
                                  fontFamily: "Merriweather",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            )
                          ])),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "You can pay on delivery via cash or UPI.",
                        style: TextStyle(fontFamily: "Merriweather"),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: width * 0.9,
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          onPressed: () async {
                            List<String> orderJson = new List();
                            for (var elem in orders) {
                              Order order = elem as Order;
                              orderJson.add(order.toJson());
                            }
                            FinalOrder finalOrder = FinalOrder(
                                address: _addressController.text,
                                buyerName: _nameController.text,
                                phoneNumber: _phoneController.text,
                                userOrders: orderJson);
                            debugPrint(finalOrder.toJson());
                            http.Response response = await http.post(
                                Uri.encodeFull(AppString.orderUrl),
                                body: finalOrder,
                                headers: {'Content-type': 'application/json'});
                          },
                          color: Colors.green[400],
                          textColor: Colors.white,
                          child: Text("Buy now".toUpperCase(),
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Merriweather",
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      },
      label: Text(
        'Proceed'.toUpperCase(),
        style: TextStyle(fontFamily: "Merriweather", color: Colors.white),
      ),
      icon: Icon(Icons.shopping_basket),
      backgroundColor: Colors.green[400],
    );
  }
}
