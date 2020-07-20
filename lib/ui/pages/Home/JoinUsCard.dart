import 'package:f2k/ui/pages/Home/JoinUsScreen.dart';
import 'package:flutter/material.dart';

class JoinUsCard extends StatelessWidget {
  const JoinUsCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => JoinUs()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
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
                  height: 220,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1492496913980-501348b61469?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80"),
                          fit: BoxFit.cover),
                      color: Colors.grey[100]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 130, left: 20),
                child: RichText(
                  text: TextSpan(
                    text: "Join ".toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                        color: Colors.white,
                        fontFamily: "Merriweather",
                        fontSize: 26),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'U',
                          style: TextStyle(
                              color: Colors.green[400], fontSize: 34)),
                      TextSpan(text: 'S'),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 70,
                left: 10,
                child: Container(
                  width: 250,
                  child: Text(
                    "Help us to create a community of organic farmers.",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Merriweather",
                        fontSize: 16),
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
                        "Register",
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
