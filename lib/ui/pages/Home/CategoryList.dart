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
            image: "assets/images/veg.png",
            title: "Vegetable",
          ),
          CategoryCard(
            image: "assets/images/snacks.png",
            title: "Snacks",
          ),
          CategoryCard(
            image: "assets/images/fish.png",
            title: "Fish",
          ),
          CategoryCard(
            image: "assets/images/poultry.png",
            title: "Poultry",
          ),
          CategoryCard(
            image: "assets/images/beef.png",
            title: "Meat",
          ),
        ],
      ),
    );
  }
}
