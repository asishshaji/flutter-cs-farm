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
  String imageurl;
  @HiveField(9)
  String crossprice;
  @HiveField(10)
  String offerType;

  Product({
    this.category,
    this.sId,
    this.name,
    this.price,
    this.count,
    this.details,
    this.benifits,
    this.farmId,
    this.imageurl,
    this.crossprice,
    this.offerType,
  });

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
      'imageurl': imageurl,
      'crossprice': crossprice,
      'offerType': offerType,
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
      imageurl: map['imageurl'],
      crossprice: map['crossprice'],
      offerType: map['offerType'],
    );
  }

  Product.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    count = json['count'];
    details = json['details'];
    benifits = json['benifits'];
    farmId = json['farmId'];
    imageurl = json['imageurl'];
    crossprice = json['crossprice'];
    offerType = json['offerType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['count'] = this.count;
    data['details'] = this.details;
    data['benifits'] = this.benifits;
    data['farmId'] = this.farmId;
    data['imageurl'] = this.imageurl;
    data['crossprice'] = this.crossprice;
    data['offerType'] = this.offerType;
    return data;
  }
}
