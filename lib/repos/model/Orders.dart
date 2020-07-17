import 'dart:convert';

import 'package:hive/hive.dart';

import 'Product.dart';

part 'Orders.g.dart';

@HiveType()
class Order {
  @HiveField(0)
  final String orderCount;
  @HiveField(1)
  final Product product;

  Order({
    this.orderCount,
    this.product,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderCount': orderCount,
      'product': product?.toMap(),
    };
  }

  static Order fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Order(
      orderCount: map['orderCount'],
      product: Product.fromMap(map['product']),
    );
  }

  String toJson() => json.encode(toMap());

  static Order fromJson(String source) => fromMap(json.decode(source));
}
