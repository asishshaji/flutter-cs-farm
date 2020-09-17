import 'package:f2k/ui/pages/Home/Home.dart';
import 'package:f2k/ui/pages/Login.dart';
import 'package:f2k/ui/pages/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthNavigation extends StatefulWidget {
  AuthNavigation({Key key}) : super(key: key);

  @override
  _AuthNavigationState createState() => _AuthNavigationState();
}

class _AuthNavigationState extends State<AuthNavigation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Home();
  }
}
