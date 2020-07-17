import 'dart:convert';

import 'package:hive/hive.dart';

part 'Product.g.dart';

@HiveType()
class Product {
  @HiveField(0)
  String category;
  @HiveField(1)
  String sId;
  @HiveField(2)
  String name;
  @HiveField(3)
  String price;
  @HiveField(4)
  int count;
  @HiveField(5)
  String details;
  @HiveField(6)
  String benifits;
  @HiveField(7)
  String farmId;
  @HiveField(8)
  int iV;

  Product(
      {this.category,
      this.sId,
      this.name,
      this.price,
      this.count,
      this.details,
      this.benifits,
      this.farmId,
      this.iV});

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'sId': sId,
      'name': name,
      'price': price,
      'count': count,
      'details': details,
      'benifits': benifits,
      'farmId': farmId,
      'iV': iV,
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Product(
      category: map['category'],
      sId: map['sId'],
      name: map['name'],
      price: map['price'],
      count: map['count'],
      details: map['details'],
      benifits: map['benifits'],
      farmId: map['farmId'],
      iV: map['iV'],
    );
  }

  String toJson() => json.encode(toMap());

  static Product fromJson(String source) => fromMap(json.decode(source));
}
