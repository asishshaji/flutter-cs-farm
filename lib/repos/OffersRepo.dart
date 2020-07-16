import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:f2k/repos/model/Offers.dart';
import 'package:f2k/res/AppString.dart';
import 'package:f2k/services/HiveService.dart';
import 'package:http/http.dart' as http;

class OffersRepo extends Equatable {
  Future<List<dynamic>> getOffer() async {
    List<dynamic> offers = List<Offer>();
    bool exists = await HiveService.isExists(boxName: "offers");
    if (exists) {
      offers = await HiveService.getBoxes("offers");
    } else {
      var response = await http.get(AppString.offerUrl);
      if (response.statusCode == 200) {
        var jsonReponse = json.decode(response.body);

        (jsonReponse as List).map((off) {
          Offer offer = Offer.fromJson(off);
          offers.add(offer);
        }).toList();
        await HiveService.addBoxes(offers, "offers");
      }
    }

    return offers;
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}
