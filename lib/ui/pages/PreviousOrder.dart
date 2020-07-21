import 'package:cached_network_image/cached_network_image.dart';
import 'package:f2k/ui/pages/Product/ProductDetail.dart';
import 'package:f2k/ui/pages/Sorry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PreviousOrdersScreen extends StatefulWidget {
  PreviousOrdersScreen({Key key}) : super(key: key);

  @override
  _PreviousOrdersScreenState createState() => _PreviousOrdersScreenState();
}

class _PreviousOrdersScreenState extends State<PreviousOrdersScreen> {
  List<dynamic> orders = new List<dynamic>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getOrdersFromHive();
    });
  }

  _getOrdersFromHive() async {
    final openBox = await Hive.openBox("Orders");
    List<dynamic> temp = new List<dynamic>();

    for (int i = openBox.length - 1; i > 0; i--) {
      var box = openBox.getAt(i);
      temp.add(box);
    }

    setState(() {
      orders = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: orders.length != 0
            ? ListView.builder(
                itemCount: orders.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  dynamic order = orders[index];
                  return buildCard(width, context, order, index);
                })
            : ErrorSorry(msg: "You haven't made any orders"),
      ),
    );
  }

  Padding buildCard(double width, BuildContext context, order, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
      child: Container(
        width: width,
        height: 150,
        child: Column(
          children: <Widget>[
            Row(
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
                Text(order.product.name),
                Text(order.orderCount),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
