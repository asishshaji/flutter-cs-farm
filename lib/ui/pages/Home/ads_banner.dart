import 'package:animations/animations.dart';
import 'package:f2k/repos/model/Offers.dart';
import 'package:f2k/ui/pages/AdDetail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Ads extends StatelessWidget {
  final Offer offer;

  const Ads({Key key, this.offer}) : super(key: key);

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
          AdDetail(offer: offer),
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
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.grey.shade800,
                      Colors.grey.shade600,
                      Colors.grey.shade800,
                    ]).createShader(bounds);
              },
              child: Container(
                height: 200,
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
                style: GoogleFonts.dmSans(
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
                child: Text(
                  "See more >",
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
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
