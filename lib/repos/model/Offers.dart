import 'package:hive/hive.dart';

part 'Offers.g.dart';

@HiveType()
class Offer {
  @HiveField(0)
  String sId;
  @HiveField(1)
  String title;
  @HiveField(2)
  String details;
  @HiveField(3)
  String imageurl;
  @HiveField(4)
  int iV;

  Offer({this.sId, this.title, this.details, this.imageurl, this.iV});

  Offer.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    details = json['details'];
    imageurl = json['imageurl'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['details'] = this.details;
    data['imageurl'] = this.imageurl;
    data['__v'] = this.iV;
    return data;
  }
}
