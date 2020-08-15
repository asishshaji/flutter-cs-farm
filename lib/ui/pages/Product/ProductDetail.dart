import 'package:cached_network_image/cached_network_image.dart';
import 'package:f2k/repos/model/Orders.dart';
import 'package:f2k/repos/model/Product.dart';
import 'package:f2k/ui/pages/BuildTextField.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:toast/toast.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({Key key, this.product}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  TextEditingController _quantityController = new TextEditingController();

  String phoneNumber;
  double quantity;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
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
                  height: height * 0.5,
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
                            controller: _quantityController,
                            icon: Icons.view_module,
                            hintText: "Quantity",
                            textInputType: TextInputType.phone),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          width: width * 0.9,
                          height: 50,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            onPressed: () async {
                              String quantity = _quantityController.text;
                              Order order = Order(
                                  orderCount: quantity,
                                  product: widget.product);
                              if (int.parse(quantity) <= widget.product.count) {
                                final box = await Hive.openBox("Cart");
                                bool inCart = false;
                                for (var val in box.values) {
                                  if (val.product.sId == order.product.sId)
                                    inCart = true;
                                }
                                if (!inCart) {
                                  box.add(order);
                                  Toast.show(
                                      "${widget.product.name} added to cart",
                                      context,
                                      gravity: Toast.BOTTOM);
                                } else
                                  Toast.show(
                                      "${widget.product.name} already in cart",
                                      context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM);

                                Navigator.pop(context);
                              } else {
                                Toast.show("Check your quantity", context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
                              }
                            },
                            color: Colors.green[400],
                            textColor: Colors.white,
                            child: Text("Add to cart".toUpperCase(),
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
          'Add to cart'.toUpperCase(),
          style: TextStyle(fontFamily: "Merriweather", color: Colors.white),
        ),
        icon: Icon(Icons.add_shopping_cart),
        backgroundColor: Colors.green[400],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
                tag: "${widget.product.sId}",
                child: CachedNetworkImage(
                  imageUrl: widget.product.imageurl,
                  imageBuilder: (context, imageProvider) => Container(
                    height: height * 0.4,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.3, color: Colors.grey[400]),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50)),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) => Container(
                      height: height * 0.4,
                      child: Center(child: CircularProgressIndicator())),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                widget.product.name,
                style: TextStyle(
                  fontFamily: "Merriweather",
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  buildCount(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          "₹ ${widget.product.crossprice ?? "0"}",
                          style: TextStyle(
                              fontFamily: "Merriweather",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.green.shade300),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          "₹ ${widget.product.price}",
                          style: TextStyle(
                              fontFamily: "Merriweather",
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[400]),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                widget.product.details,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontFamily: "Merriweather"),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Benifits",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontFamily: "Merriweather"),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                widget.product.benifits ?? "",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontFamily: "Merriweather"),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Container buildCount() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black26)),
      child: Column(
        children: <Widget>[
          Expanded(
              child: Center(
                  child: Text(widget.product.count.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Merriweather",
                          fontWeight: FontWeight.bold)))),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(7),
                  bottomRight: Radius.circular(7)),
              color: Colors.green[400],
            ),
            child: Center(
                child: Text(
              "In farms",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: "Merriweather",
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
          ))
        ],
      ),
    );
  }
}
