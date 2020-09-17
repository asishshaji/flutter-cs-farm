import 'dart:convert';

import 'package:f2k/repos/model/Product.dart';
import 'package:f2k/res/AppString.dart';
import 'package:http/http.dart' as http;

class PackRepo {
  Future<List<dynamic>> getPacks() async {
    List<dynamic> products = new List();
    var response = await http.get(AppString.productCatUrl + "Pack");
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
