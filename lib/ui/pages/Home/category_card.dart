import 'package:f2k/ui/pages/Product/ProductList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryCard extends StatelessWidget {
  final String image, title;
  final List<Color> colors;

  const CategoryCard({Key key, this.image, this.title, this.colors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (
                BuildContext context,
              ) {
                return ProductListScreen(category: title);
              }));
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                image,
                height: 100,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              title,
              style: GoogleFonts.dmSans(color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }
}
