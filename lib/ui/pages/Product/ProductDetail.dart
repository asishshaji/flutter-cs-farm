import 'package:f2k/repos/model/Product.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: Text('Buy Now'),
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
                product.name,
                style: TextStyle(
                    fontFamily: "Merriweather",
                    fontSize: 26,
                    fontWeight: FontWeight.w700),
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
                      product.price,
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
                product.details,
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
                  child: Text(product.count.toString(),
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
