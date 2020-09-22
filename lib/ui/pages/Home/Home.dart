import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_drawer/curved_drawer.dart';
import 'package:f2k/blocs/offersbloc/offers_bloc.dart';
import 'package:f2k/blocs/productbloc/products_bloc.dart';
import 'package:f2k/repos/PackRepo.dart';
import 'package:f2k/repos/ProductRepo.dart';
import 'package:f2k/res/AppString.dart';
import 'package:f2k/ui/pages/Home/CategoryList.dart';
import 'package:f2k/ui/pages/Home/PackCard.dart';
import 'package:f2k/ui/pages/Home/Search.dart';
import 'package:f2k/ui/pages/Home/ads_banner.dart';
import 'package:f2k/ui/pages/Orders.dart';
import 'package:f2k/ui/pages/Product/ProductDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ProductsBloc _productsBloc;
  OffersBloc _offersBloc;
  int index = 0;
  List<dynamic> pincodes;

  @override
  void initState() {
    super.initState();
    _productsBloc = BlocProvider.of<ProductsBloc>(context);
    _offersBloc = BlocProvider.of<OffersBloc>(context);
    _offersBloc.add(GetOffers());
    _productsBloc.add(GetRandomProductStartEvent());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getPincodes();
    });
  }

  _getPincodes() async {
    var response = await http.get(AppString.pincodes);
    if (response.statusCode == 200) {
      var jsonReponse = json.decode(response.body);
      pincodes = jsonReponse as List;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFAB(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "GreenaryMart",
          style: GoogleFonts.dmSans(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute(builder: (
                BuildContext context,
              ) {
                return SearchScreen();
              }));
            },
          )
        ],
      ),
      // drawer: CurvedDrawer(
      //   color: Colors.white,
      //   labelColor: Colors.black54,
      //   width: 72.0,
      //   items: <DrawerItem>[
      //     DrawerItem(icon: Icon(Icons.perm_camera_mic)),
      //     //Optional Label Text
      //     DrawerItem(icon: Icon(Icons.ac_unit), label: "Messages")
      //   ],
      //   onTap: (newIndex) {
      //     setState(() {
      //       index = newIndex;
      //     });
      //     if (index == 0) {
      //     } else if (index == 2) {
      //       Navigator.of(context).push(MaterialPageRoute(
      //           builder: (BuildContext context) => OrderScreen()));
      //     }
      //   },
      // ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            buildPackCarousel(),
            const SizedBox(
              height: 20,
            ),
            pincodes != null
                ? Container(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      "Available at ${pincodes.join(",")}",
                      style: GoogleFonts.dmSans(fontSize: 16),
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 20,
            ),
            buildCategoryContainer(),
            buildAds(),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Text(
                "Best selling",
                style: GoogleFonts.dmSans(
                  fontSize: 22,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            buildRandomProducts(),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<List> buildRandomProducts() {
    return FutureBuilder(
      future: ProductRepository().getRandomProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green[600],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: new NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (
                        BuildContext context,
                      ) {
                        return ProductDetailScreen(
                            product: snapshot.data[index]);
                      }));
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Hero(
                                tag: "${snapshot.data[index].sId}",
                                child: Image.network(
                                  snapshot.data[index].imageurl,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              snapshot.data[index].name,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  GoogleFonts.dmSans(color: Colors.grey[800]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data.length,
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.green[600],
            ),
          );
        }
      },
    );
  }

  BlocBuilder<OffersBloc, OffersState> buildAds() {
    return BlocBuilder(
        builder: (BuildContext context, OffersState state) {
          if (state is OffersInitial) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green[600],
              ),
            );
          } else if (state is OffersLoadedState) {
            List<dynamic> offers = state.loadedOffers;

            return CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                height: 200,
                enlargeCenterPage: true,
              ),
              items: offers.map((offer) {
                return Ads(
                  offer: offer,
                );
              }).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green[600],
              ),
            );
          }
        },
        bloc: _offersBloc);
  }

  FutureBuilder<List> buildPackCarousel() {
    return FutureBuilder(
      future: PackRepo().getPacks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            if (snapshot.data.length != 0)
              return CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  height: 200,
                  enlargeCenterPage: true,
                ),
                items: snapshot.data.map<Widget>((pack) {
                  return PackCard(
                    pack: pack,
                  );
                }).toList(),
              );
            else
              return const SizedBox();
          } else if (snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green[400],
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.green[400],
            ),
          );
        }
      },
    );
  }

  Container buildCategoryContainer() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              "Categories",
              style: GoogleFonts.dmSans(
                fontSize: 22,
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          CategoryList(),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  FutureBuilder<Box> buildFAB() {
    return FutureBuilder(
        future: Hive.openBox("Cart"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.green[600],
                ),
              );
            } else {
              return FloatingActionButton.extended(
                backgroundColor: Colors.green[600],
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => OrderScreen()));
                },
                label: Text(
                  "View Cart".toUpperCase(),
                  style: GoogleFonts.dmSans(fontSize: 12),
                ),
                icon: Icon(Icons.shopping_basket),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green[600],
              ),
            );
          }
        });
  }
}
