import 'package:f2k/repos/model/Offers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdDetail extends StatelessWidget {
  final Offer offer;

  const AdDetail({Key key, this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(offer.imageurl),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              offer.title.toUpperCase(),
              style: GoogleFonts.dmSans(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            Text(
              offer.details,
              style: GoogleFonts.dmSans(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      )),
    ));
  }
}
