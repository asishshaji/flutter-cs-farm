import 'dart:convert';

import 'package:f2k/repos/model/Product.dart';
import 'package:f2k/res/AppString.dart';
import 'package:f2k/ui/pages/Product/ProductDetail.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatelessWidget {
  Future<List<Product>> getProducts(String search) async {
    List<Product> products = List<Product>();

    var response = await http.post(
      AppString.search,
      body: jsonEncode(
        <String, String>{
          'search': search,
        },
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      var jsonReponse = json.decode(response.body);
      (jsonReponse as List).map((e) {
        Product product = Product.fromJson(e);
        products.add(product);
      }).toList();
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SearchBar<Product>(
            hintText: "Search for products",
            headerPadding: const EdgeInsets.all(5),
            hintStyle: GoogleFonts.dmSans(),
            searchBarPadding: const EdgeInsets.all(10),
            onSearch: getProducts,
            onItemFound: (Product post, int index) {
              return ListTile(
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (
                    BuildContext context,
                  ) {
                    return ProductDetailScreen(product: post);
                  }));
                },
                title: Text(
                  post.name,
                  style: GoogleFonts.dmSans(
                    color: Colors.black,
                  ),
                ),
                leading: Image.network(
                  post.imageurl,
                  width: 80,
                  height: 80,
                ),
                subtitle: Text(
                  "₹ ${post.price}",
                  style: GoogleFonts.dmSans(
                    color: Colors.grey[700],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
