import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:f2k/repos/model/Offers.dart';
import 'package:f2k/res/AppString.dart';
import 'package:f2k/services/HiveService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OffersRepo extends Equatable {
  Future<List<Offer>> getOffer() async {
    List<Offer> offers = List<Offer>();

    bool exists = await HiveService.isExists(boxName: "offers");
    if (exists) {
      debugPrint("Fetching data from hive");
      offers = await HiveService.getBoxes("offers");
    } else {
      debugPrint("Fetching from api");
      var response = await http.get(AppString.offerUrl);
      debugPrint(response.body.toString());
      if (response.statusCode == 200) {
        var jsonReponse = json.decode(response.body);

        var offersJson = jsonReponse as List;

        offersJson.forEach((offer) {
          offers.add(Offer.fromJson(offer));
        });
      }

      await HiveService.addBoxes(offers, "offers");
    }

    return offers;
  }

  @override
  // TODO: implement props
  List<Object> get props => [];
}
