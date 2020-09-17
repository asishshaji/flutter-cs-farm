import 'package:f2k/ui/pages/Home/category_card.dart';
import 'package:flutter/material.dart';

class CategoriesListScreen extends StatelessWidget {
  const CategoriesListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GridView.count(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          crossAxisCount: 2,
          children: [
            CategoryCard(
              image: "assets/images/veg.png",
              title: "Vegetable",
              colors: [Colors.green[100], Colors.greenAccent[200]],
            ),
            CategoryCard(
              image: "assets/images/snacks.png",
              title: "Snacks",
              colors: [Colors.grey[100], Colors.black12],
            ),
            CategoryCard(
              image: "assets/images/fish.png",
              title: "Fish",
              colors: [
                Colors.blue[100],
                Colors.lightBlue[300],
              ],
            ),
            CategoryCard(
              image: "assets/images/poultry.png",
              title: "Poultry",
              colors: [
                Colors.grey[100],
                Colors.grey[300],
              ],
            ),
            CategoryCard(
              image: "assets/images/beef.png",
              title: "Meat",
              colors: [
                Colors.red[200],
                Colors.redAccent[200],
                Colors.pinkAccent[200]
              ],
            ),
            CategoryCard(
              image: "assets/images/rice.png",
              title: "Rice",
              colors: [
                Colors.grey[100],
                Colors.grey[300],
              ],
            ),
            CategoryCard(
              image: "assets/images/sauce.png",
              title: "Sauce",
              colors: [
                Colors.grey[100],
                Colors.grey[300],
              ],
            ),
            CategoryCard(
              image: "assets/images/dals.png",
              title: "Dals",
              colors: [
                Colors.grey[100],
                Colors.grey[300],
              ],
            ),
            CategoryCard(
              image: "assets/images/beauty.png",
              title: "Beauty",
              colors: [
                Colors.grey[100],
                Colors.grey[300],
              ],
            ),
            CategoryCard(
              image: "assets/images/baby.png",
              title: "Baby",
              colors: [
                Colors.grey[100],
                Colors.grey[300],
              ],
            ),
            CategoryCard(
              image: "assets/images/stationary.png",
              title: "Stationary",
              colors: [
                Colors.grey[100],
                Colors.grey[300],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
