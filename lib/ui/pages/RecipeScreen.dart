import 'package:f2k/ui/pages/Sorry.dart';
import 'package:flutter/material.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ErrorSorry(
        msg: "Will be added soon",
      ),
    );
  }
}
