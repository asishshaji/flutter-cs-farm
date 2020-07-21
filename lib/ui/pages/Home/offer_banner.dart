import 'package:animations/animations.dart';
import 'package:f2k/repos/model/Offers.dart';
import 'package:f2k/ui/pages/OfferDetail.dart';
import 'package:flutter/material.dart';

class Offers extends StatelessWidget {
  final Offer offer;

  const Offers({Key key, this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return OpenContainer(
      closedElevation: 0,
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      transitionDuration: Duration(milliseconds: 500),
      closedBuilder: (BuildContext c, VoidCallback action) =>
          buildCenter(screenWidth),
      openBuilder: (BuildContext c, VoidCallback action) =>
          OfferDetail(offer: offer),
      tappable: true,
    );
  }

  Center buildCenter(double screenWidth) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Stack(
          children: <Widget>[
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black,
                      Colors.grey[400],
                      Colors.grey[700]
                    ]).createShader(bounds);
              },
              child: Container(
                height: 300,
                width: screenWidth * 0.95,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(offer.imageurl), fit: BoxFit.cover),
                    color: Colors.grey[100]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 130, left: 20),
              child: Text(
                offer.title,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    color: Colors.white,
                    fontFamily: "Merriweather",
                    fontSize: 26),
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
                child: Text(
                  "See more >",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: "Merriweather"),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
