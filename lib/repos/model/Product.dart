class Product {
  String category;
  String sId;
  String name;
  String price;
  int count;
  String details;
  String benifits;
  String farmId;
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
