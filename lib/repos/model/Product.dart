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

  Product.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    count = json['count'];
    details = json['details'];
    benifits = json['benifits'];
    farmId = json['farmId'];
    iV = json['__v'];
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
    data['__v'] = this.iV;
    return data;
  }
}
