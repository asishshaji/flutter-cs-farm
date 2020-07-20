import 'package:f2k/ui/pages/BuildTextField.dart';
import 'package:flutter/material.dart';

class JoinUs extends StatefulWidget {
  JoinUs({Key key}) : super(key: key);

  @override
  _JoinUsState createState() => _JoinUsState();
}

class _JoinUsState extends State<JoinUs> {
  final dataKey = new GlobalKey();
  TextEditingController _nameController = new TextEditingController();

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
                              image: NetworkImage(
                                  "https://images.unsplash.com/photo-1580792442222-081d7796d896?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80"),
                              fit: BoxFit.cover),
                          color: Colors.grey[100]),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 15,
                    right: 15,
                    bottom: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: "Join ",
                            style: TextStyle(
                                fontFamily: "Merriweather",
                                fontSize: 44,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'G',
                                  style: TextStyle(
                                      color: Colors.green[400], fontSize: 46)),
                              TextSpan(text: 'reen \nMart'),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.all(15),
                          elevation: 2,
                          color: Colors.green[400],
                          onPressed: () {
                            Scrollable.ensureVisible(dataKey.currentContext);
                          },
                          child: Text(
                            "പങ്കാളിയാകുക",
                            style: TextStyle(
                                fontFamily: "Merriweather",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Flexible(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "നിങ്ങൾക്ക് ഒരു ഓർഗാനിക് ഫാം ഉണ്ടെങ്കിൽ, നിങ്ങളുടെ ഉൽപ്പന്നങ്ങൾ വിൽക്കാൻ പ്രയാസമുണ്ടെങ്കിൽ, ഞങ്ങളെ ബന്ധപ്പെടുക. വിശാലമായ ഒരു ഉപഭോക്തൃ അടിത്തറ ഞങ്ങൾ നിങ്ങൾക്ക് നൽകുന്നു.",
                              style: TextStyle(
                                  fontFamily: "Merriweather",
                                  fontSize: 17,
                                  color: Colors.white70),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height - 190,
              child: Column(
                key: dataKey,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: RichText(
                      text: TextSpan(
                        text: "Fill the form to join ",
                        style: TextStyle(
                            fontFamily: "Merriweather",
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700]),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'G',
                              style: TextStyle(
                                color: Colors.green[400],
                              )),
                          TextSpan(text: 'reen Mart'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BuildTextField(
                      width: MediaQuery.of(context).size.width * 0.9,
                      controller: _nameController,
                      icon: Icons.person,
                      hintText: "Name",
                      textInputType: TextInputType.text),
                  BuildTextField(
                      width: MediaQuery.of(context).size.width * 0.9,
                      controller: _nameController,
                      icon: Icons.phone,
                      hintText: "Phone number",
                      textInputType: TextInputType.phone),
                  SizedBox(
                    height: 40,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 12),
                    elevation: 0,
                    color: Colors.green[400],
                    onPressed: () {},
                    child: Text(
                      "Submit".toUpperCase(),
                      style: TextStyle(
                          fontFamily: "Merriweather",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
