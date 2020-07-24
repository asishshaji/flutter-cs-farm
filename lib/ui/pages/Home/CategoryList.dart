import 'package:flutter/material.dart';

import 'category_card.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CategoryCard(
              image: "assets/images/fish.png",
              title: "Fish",
              colors: [Colors.blue[100], Colors.lightBlue[300]]),
          CategoryCard(image: "assets/images/beef.png", title: "Meat", colors: [
            Colors.red[200],
            Colors.redAccent[200],
            Colors.pinkAccent[200]
          ]),
          CategoryCard(
            image: "assets/images/veg.png",
            title: "Vegetable",
            colors: [Colors.green[100], Colors.greenAccent[200]],
          ),
          CategoryCard(
            image: "assets/images/poultry.png",
            title: "Poultry",
            colors: [Colors.grey[100], Colors.grey[300]],
          ),
          CategoryCard(
            image: "assets/images/snacks.png",
            title: "Snacks",
            colors: [Colors.grey[100], Colors.black12],
          ),
        ],
      ),
    );
  }
}
