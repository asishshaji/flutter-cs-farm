import 'dart:convert';

class FinalOrder {
  String buyerName;
  String phoneNumber;
  String address;
  List<dynamic> userOrders;
  String message;

  FinalOrder({
    this.buyerName,
    this.phoneNumber,
    this.address,
    this.userOrders,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'buyerName': buyerName,
      'phoneNumber': phoneNumber,
      'address': address,
      'userOrders': userOrders,
      'message': message,
    };
  }

  String toJson() => json.encode(toMap());
}
