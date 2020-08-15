import 'dart:convert';

import 'package:f2k/repos/model/Product.dart';
import 'package:f2k/res/AppString.dart';
import 'package:http/http.dart' as http;

class PackRepo {
  Future<List<dynamic>> getPacks() async {
    List<dynamic> _packs = new List();

    var response = await http.get(AppString.packs);

    var jsonResponse = json.decode(response.body);

    (jsonResponse as List).map((pack) {
      Product product = Product.fromJson(pack);
      _packs.add(product);
    }).toList();

    return _packs;
  }

  makeOrder() async {}
}
