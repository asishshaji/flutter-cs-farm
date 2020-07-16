import 'package:f2k/repos/model/Product.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  TextEditingController _nameController;
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _quantityController = new TextEditingController();

  String userName;
  String phoneNumber;
  double quantity;
  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.currentUser().then((value) {
      setState(() {
        userName = value.displayName;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    _nameController = new TextEditingController(text: userName);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final box = await Hive.openBox("Cart");
          box.add(widget.product);
          Toast.show("${widget.product.name} added to cart", context,
              gravity: Toast.BOTTOM);
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
            Container(
              height: height * 0.4,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[400],
                    blurRadius: 25.0, // soften the shadow
                    spreadRadius: 5.0, //extend the shadow
                    offset: Offset(
                      15.0, // Move to right 10  horizontally
                      15.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1550081699-79c1c2e48a77?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80")),
              ),
            ),
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
                    fontWeight: FontWeight.w800),
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
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      widget.product.price,
                      style: TextStyle(
                          fontFamily: "Merriweather",
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[400]),
                    ),
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
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Theme buildTextField(double width, TextEditingController controller,
      IconData icon, String hintText, TextInputType textInputType) {
    return Theme(
      data: new ThemeData(
        primaryColor: Colors.green[400],
        primaryColorDark: Colors.greenAccent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Container(
          width: width * 0.9,
          child: TextField(
            keyboardType: textInputType,
            style:
                TextStyle(color: Colors.grey[700], fontFamily: "Merriweather"),
            decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                  gapPadding: 5,
                ),
                prefixIcon: Icon(icon)),
            controller: controller,
          ),
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
