import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import 'package:f2k/repos/model/Product.dart';
import 'package:f2k/res/AppString.dart';

class ProductRepository extends Equatable {
  Future<List<Product>> getProductsByCategory(String category) async {
    List<Product> offers = List<Product>();
    // fetching from API
    var response = await http.get(AppString.productCatUrl + category);
    if (response.statusCode == 200) {
      var jsonReponse = json.decode(response.body);
      var offersJson = jsonReponse as List;

      offersJson.forEach((offer) {
        offers.add(Product.fromJson(offer));
      });
    }
    return offers;
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
