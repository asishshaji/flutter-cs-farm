import 'dart:convert';

import 'package:f2k/repos/model/Product.dart';
import 'package:f2k/res/AppString.dart';
import 'package:f2k/services/HiveService.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<List<dynamic>> getProductsByCategory(String category) async {
    List<dynamic> products = List<dynamic>();
    bool exists = await HiveService.isExists(boxName: category);

    if (exists) {
      products = await HiveService.getBoxes(category);
    } else {
      var response = await http.get(AppString.productCatUrl + category);
      if (response.statusCode == 200) {
        var jsonReponse = json.decode(response.body);
        (jsonReponse as List).map((e) {
          Product product = Product.fromJson(e);
          products.add(product);
        }).toList();
        await HiveService.addBoxes(products, category);
      }
    }

    return products;
  }

  Future<List<dynamic>> searchProduct(String search) async {
    List<dynamic> products = List<dynamic>();

    var response = await http.get(AppString.search);
    if (response.statusCode == 200) {
      var jsonReponse = json.decode(response.body);
      (jsonReponse as List).map((e) {
        Product product = Product.fromJson(e);
        products.add(product);
      }).toList();
    }

    return products;
  }

  Future<List<dynamic>> fetchFromAPI(String category) async {
    List<dynamic> products = List<dynamic>();

    var response = await http.get(AppString.productCatUrl + category);
    if (response.statusCode == 200) {
      var jsonReponse = json.decode(response.body);
      (jsonReponse as List).map((e) {
        Product product = Product.fromJson(e);
        products.add(product);
      }).toList();
      await Hive.box(category).clear();
      await HiveService.addBoxes(products, category);
    }
    return products;
  }

  Future<List<dynamic>> getRandomProducts() async {
    List<dynamic> products = List<dynamic>();

    var response = await http.get(AppString.random);
    if (response.statusCode == 200) {
      var jsonReponse = json.decode(response.body);
      (jsonReponse as List).map((e) {
        Product product = Product.fromJson(e);
        products.add(product);
      }).toList();
    }
    return products;
  }
}
