import 'package:f2k/repos/model/Product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    // TODO: implement initState
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
                        buildTextField(width, _nameController,
                            Icons.person_outline, "A", TextInputType.text),
                        buildTextField(width, _phoneController, Icons.phone,
                            "Phone Number", TextInputType.phone),
                        buildTextField(width, _addressController, Icons.home,
                            "Address", TextInputType.multiline),
                        buildTextField(width, _quantityController,
                            Icons.view_module, "Items", TextInputType.number),
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
                            onPressed: () {},
                            color: Colors.green[500],
                            textColor: Colors.white,
                            child: Text("Place order".toUpperCase(),
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
          'Buy Now',
          style: TextStyle(fontFamily: "Merriweather", color: Colors.white),
        ),
        icon: Icon(Icons.shopping_cart),
        backgroundColor: Colors.green[500],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: height * 0.4,
              decoration: BoxDecoration(
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
                          color: Colors.green[500]),
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
        primaryColor: Colors.green,
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
                  bottomLeft: Radius.circular(9),
                  bottomRight: Radius.circular(9)),
              color: Colors.green[500],
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
