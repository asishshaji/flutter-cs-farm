import 'package:carousel_slider/carousel_slider.dart';
import 'package:f2k/blocs/offersbloc/offers_bloc.dart';
import 'package:f2k/blocs/productbloc/products_bloc.dart';
import 'package:f2k/repos/ProductRepo.dart';
import 'package:f2k/repos/model/Offers.dart';
import 'package:f2k/repos/model/Product.dart';
import 'package:f2k/ui/pages/Home/CategoryList.dart';
import 'package:f2k/ui/pages/Home/offer_banner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'category_card.dart';

class Home extends StatefulWidget {
  final FirebaseUser user;
  Home({Key key, @required this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ProductsBloc _productsBloc;
  OffersBloc _offersBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productsBloc = BlocProvider.of<ProductsBloc>(context);
    _offersBloc = BlocProvider.of<OffersBloc>(context);
    _offersBloc.add(GetOffers());
    _productsBloc.add(ProductStartEvent(category: "Vegetable"));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Hey ${widget.user.displayName.split(" ")[0]},",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            fontFamily: "Merriweather",
                            color: Colors.grey[700]),
                      ),
                      CircleAvatar(
                        radius: 26,
                        backgroundImage: NetworkImage(widget.user.photoUrl),
                      )
                    ],
                  ),
                  Text(
                    "Find fresh products🍄🍉",
                    style: TextStyle(
                        fontFamily: "Merriweather",
                        fontSize: 24,
                        color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          BlocBuilder(
              builder: (BuildContext context, OffersState state) {
                if (state is OffersInitial) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is OffersLoadedState) {
                  List<dynamic> offers = state.loadedOffers;

                  return CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      height: 200,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 7),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                    ),
                    items: offers.map((offer) {
                      return Offers(
                        imageurl: offer.imageurl,
                        title: offer.title,
                      );
                    }).toList(),
                  );
                }
              },
              bloc: _offersBloc),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: "Merriweather",
                        fontSize: 32),
                  ),
                ),
                CategoryList(),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    "Best Selling",
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: "Merriweather",
                        fontSize: 32),
                  ),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
