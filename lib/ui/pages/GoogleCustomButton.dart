import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class GoogleButtonCustom extends StatelessWidget {
  final Function function;
  const GoogleButtonCustom({Key key, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset("assets/logo.png"),
        ),
        const SizedBox(
          height: 30,
        ),
        SignInButton(
          Buttons.Google,
          onPressed: function,
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
