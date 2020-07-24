import 'package:f2k/repos/model/FinalOrder.dart';
import 'package:f2k/repos/model/Orders.dart';
import 'package:f2k/res/AppString.dart';
import 'package:f2k/services/HiveService.dart';
import 'package:f2k/ui/pages/BuildTextField.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class BottomModal extends StatefulWidget {
  final List<dynamic> orders;
  final double totalPrice;
  final dynamic getdata;
  final String userName;

  BottomModal(
      {Key key, this.orders, this.totalPrice, this.getdata, this.userName})
      : super(key: key);

  @override
  _BottomModalState createState() => _BottomModalState();
}

class _BottomModalState extends State<BottomModal> {
  TextEditingController _nameController;
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();

  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    _nameController = new TextEditingController(text: widget.userName);

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
                              text: "   ₹ ${widget.totalPrice}",
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
                            setState(() {
                              showProgress = !showProgress;
                            });

                            List<dynamic> orderJson = new List();
                            for (var elem in widget.orders) {
                              Order order = elem as Order;
                              orderJson.add(order);
                            }
                            FinalOrder finalOrder = FinalOrder(
                                address: _addressController.text,
                                buyerName: _nameController.text,
                                phoneNumber: _phoneController.text,
                                userOrders: orderJson);
                            Toast.show(
                                "Order is being placed, wait...", context,
                                gravity: Toast.CENTER);
                            await http.get(
                              "https://csf2k.herokuapp.com/",
                            );

                            http.Response response = await http.post(
                                AppString.orderUrl,
                                body: finalOrder.toJson(),
                                headers: {'Content-type': 'application/json'});

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
                                  "${response.body} is not available, try refreshing the app}",
                                  context,
                                  gravity: Toast.CENTER,
                                  duration: Toast.LENGTH_LONG);
                            }
                          },
                          color: Colors.green[400],
                          textColor: Colors.white,
                          child: Text("Buy now".toUpperCase(),
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Merriweather",
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (showProgress)
                        CircularProgressIndicator(
                          backgroundColor: Colors.green[400],
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
