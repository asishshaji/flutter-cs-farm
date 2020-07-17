import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: null),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: CircleAvatar(
                  radius: 82,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                        "https://randomuser.me/api/portraits/men/31.jpg"),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "John Doe",
              style: TextStyle(fontFamily: "Merriweather", fontSize: 28),
            )
          ],
        ),
      ),
    );
  }
}
