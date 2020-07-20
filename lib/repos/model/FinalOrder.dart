import 'dart:convert';

class FinalOrder {
  String buyerName;
  String phoneNumber;
  String address;
  List<dynamic> userOrders;

  FinalOrder({
    this.buyerName,
    this.phoneNumber,
    this.address,
    this.userOrders,
  });

  Map<String, dynamic> toMap() {
    return {
      'buyerName': buyerName,
      'phoneNumber': phoneNumber,
      'address': address,
      'userOrders': userOrders,
    };
  }

  String toJson() => json.encode(toMap());
}
