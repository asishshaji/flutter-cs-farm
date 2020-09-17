import 'package:f2k/repos/model/Offers.dart';
import 'package:flutter/material.dart';

class AdDetail extends StatelessWidget {
  final Offer offer;

  const AdDetail({Key key, this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black,
                            Colors.grey[600],
                            Colors.grey[900]
                          ]).createShader(bounds);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(offer.imageurl),
                              fit: BoxFit.cover),
                          color: Colors.grey[100]),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 20,
                    right: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          offer.title.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: "Merriweather",
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                        ),
                        Text(
                          offer.details,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "Merriweather",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
