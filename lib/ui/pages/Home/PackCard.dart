import 'package:f2k/repos/model/Product.dart';
import 'package:f2k/ui/pages/Product/ProductDetail.dart';
import 'package:flutter/material.dart';

class PackCard extends StatelessWidget {
  const PackCard({
    Key key,
    this.pack,
  }) : super(key: key);
  final Product pack;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => ProductDetailScreen(
                    product: pack,
                  )));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          child: Stack(
            children: <Widget>[
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.grey.shade800,
                        Colors.grey.shade600,
                        Colors.grey.shade800,
                      ]).createShader(bounds);
                },
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: NetworkImage(pack.imageurl),
                          fit: BoxFit.cover),
                      color: Colors.grey[100]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 130, left: 20),
                child: Text(
                  pack.name,
                  style: TextStyle(
                    fontFamily: "Merriweather",
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Know more",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Merriweather"),
                        textAlign: TextAlign.center,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
