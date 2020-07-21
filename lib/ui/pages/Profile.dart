import 'package:f2k/blocs/authbloc/auth_bloc.dart';
import 'package:f2k/ui/pages/Home/JoinUsScreen.dart';
import 'package:f2k/ui/pages/Orders.dart';
import 'package:f2k/ui/pages/PreviousOrder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthBloc _authBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Profile",
            style: TextStyle(
                fontFamily: "Merriweather",
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
          leading:
              IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: null),
        ),
        body: BlocBuilder(
          bloc: _authBloc,
          builder: (BuildContext context, AuthState state) {
            if (state is Authenticated) {
              FirebaseUser user = state.user;
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(user.photoUrl),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        user.displayName,
                        style:
                            TextStyle(fontFamily: "Merriweather", fontSize: 22),
                      ),
                      Text(
                        user.email,
                        style: TextStyle(
                            fontFamily: "Merriweather",
                            fontSize: 16,
                            color: Colors.grey[700]),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.86,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            buildTile("View Orders", () {
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (
                                BuildContext context,
                              ) {
                                return PreviousOrdersScreen();
                              }));
                            }),
                            SizedBox(
                              height: 5,
                            ),
                            buildTile("View cart", () {
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (
                                BuildContext context,
                              ) {
                                return OrderScreen();
                              }));
                            }),
                            SizedBox(
                              height: 5,
                            ),
                            buildTile("join us", () {
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (
                                BuildContext context,
                              ) {
                                return JoinUs();
                              }));
                            }),
                            SizedBox(
                              height: 5,
                            ),
                            buildTile("about us", () {}),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }

  InkWell buildTile(String text, Function onPress) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]),
            borderRadius: BorderRadius.all(Radius.circular(3))),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Center(
            child: Text(
              text.toUpperCase(),
              style: TextStyle(
                  fontFamily: "Merriweather", color: Colors.grey[700]),
            ),
          ),
        ),
      ),
    );
  }
}
