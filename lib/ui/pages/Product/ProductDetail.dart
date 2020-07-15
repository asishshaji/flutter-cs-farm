import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final String imageurl;
  const ProductDetailScreen({Key key, this.imageurl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 300,
        width: double.infinity,
        child: Image.network(
          imageurl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
