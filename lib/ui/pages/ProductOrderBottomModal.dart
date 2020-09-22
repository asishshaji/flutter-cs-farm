import 'package:f2k/repos/model/FinalOrder.dart';
import 'package:f2k/repos/model/Orders.dart';
import 'package:f2k/res/AppString.dart';
import 'package:f2k/services/HiveService.dart';
import 'package:f2k/ui/pages/BuildTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class BottomModal extends StatefulWidget {
  final List<dynamic> orders;
  final double totalPrice;
  final dynamic getdata;
  final String userName;
  final List<dynamic> pincodes;

  BottomModal({
    Key key,
    this.orders,
    this.totalPrice,
    this.getdata,
    this.userName,
    this.pincodes,
  }) : super(key: key);

  @override
  _BottomModalState createState() => _BottomModalState();
}

class _BottomModalState extends State<BottomModal> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  bool showProgress = false;
  String name;
  String phone;
  String address;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDetails();
    });
  }

  getDetails() async {
    final openBox = await Hive.openBox("Contact");

    if (openBox.isNotEmpty) {
      setState(() {
        name = openBox.get("name");
        phone = openBox.get("phone");
        address = openBox.get("address");
      });
      _nameController.text = name;
      _phoneController.text = phone;
      _addressController.text = address;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
                height: height * 0.93,
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
                      BuildTextField(
                          width: width,
                          controller: _messageController,
                          icon: Icons.message,
                          hintText: "Message",
                          textInputType: TextInputType.multiline),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                          text: TextSpan(
                              text: 'Net Price',
                              style: GoogleFonts.dmSans(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              children: <TextSpan>[
                            TextSpan(
                              text: "   ₹ ${widget.totalPrice}",
                              style: GoogleFonts.dmSans(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            )
                          ])),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "You can pay on delivery via cash or UPI.",
                        style: GoogleFonts.dmSans(),
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
                            if (_phoneController.text.isNotEmpty) {
                              if (widget.totalPrice > 100) {
                                List<dynamic> orderJson = new List();
                                for (var elem in widget.orders) {
                                  Order order = elem as Order;
                                  orderJson.add(order);
                                }

                                final openBox = await Hive.openBox("Contact");
                                openBox.put("name", _nameController.text);
                                openBox.put("phone", _phoneController.text);
                                openBox.put("address", _addressController.text);

                                FinalOrder finalOrder = FinalOrder(
                                  address: _addressController.text,
                                  buyerName: _nameController.text,
                                  phoneNumber: _phoneController.text,
                                  message: _messageController.text,
                                  userOrders: orderJson,
                                );
                                Toast.show(
                                    "Order is being placed, wait...", context,
                                    gravity: Toast.CENTER);
                                await http.get(
                                  "https://csf2k.herokuapp.com/",
                                );

                                http.Response response = await http.post(
                                    AppString.orderUrl,
                                    body: finalOrder.toJson(),
                                    headers: {
                                      'Content-type': 'application/json'
                                    });

                                if (response.body
                                        .toString()
                                        .compareTo("Order placed") ==
                                    0) {
                                  setState(() {
                                    showProgress = !showProgress;
                                  });
                                  HiveService.addBoxes(widget.orders, "Orders");
                                  await Hive.box("Cart").clear();
                                  widget.getdata();
                                  Navigator.of(context).pop();
                                } else if (response.statusCode == 333) {
                                  Toast.show(
                                      "${response.body} is out of stock, remove item from cart",
                                      context,
                                      gravity: Toast.CENTER,
                                      duration: Toast.LENGTH_LONG);
                                }
                              } else {
                                Toast.show("Minimum amount is 100", context,
                                    gravity: Toast.CENTER,
                                    duration: Toast.LENGTH_LONG);
                              }
                            } else {
                              Toast.show("Enter a valid phone number", context,
                                  gravity: Toast.CENTER,
                                  duration: Toast.LENGTH_LONG);
                            }
                          },
                          color: Colors.green[600],
                          textColor: Colors.white,
                          child: Text("Buy now".toUpperCase(),
                              style: GoogleFonts.dmSans(
                                fontSize: 12,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
      backgroundColor: Colors.green[600],
    );
  }
}
