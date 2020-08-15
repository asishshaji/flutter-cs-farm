import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_drawer/curved_drawer.dart';
import 'package:f2k/blocs/offersbloc/offers_bloc.dart';
import 'package:f2k/blocs/productbloc/products_bloc.dart';
import 'package:f2k/repos/PackRepo.dart';
import 'package:f2k/repos/ProductRepo.dart';
import 'package:f2k/ui/pages/Home/CategoryList.dart';
import 'package:f2k/ui/pages/Home/CustomMessage.dart';
import 'package:f2k/ui/pages/Home/JoinUsCard.dart';
import 'package:f2k/ui/pages/Home/PackCard.dart';
import 'package:f2k/ui/pages/Home/offer_banner.dart';
import 'package:f2k/ui/pages/Orders.dart';
import 'package:f2k/ui/pages/Product/ProductDetail.dart';
import 'package:f2k/ui/pages/Profile.dart';
import 'package:f2k/ui/pages/RecipeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class Home extends StatefulWidget {
  final FirebaseUser user;

  Home({Key key, @required this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ProductsBloc _productsBloc;
  OffersBloc _offersBloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int index = 0;

  @override
  void initState() {
    super.initState();
    _productsBloc = BlocProvider.of<ProductsBloc>(context);
    _offersBloc = BlocProvider.of<OffersBloc>(context);
    _offersBloc.add(GetOffers());
    _productsBloc.add(GetRandomProductStartEvent());
  }

  List<DrawerItem> _drawerItems = <DrawerItem>[
    DrawerItem(icon: Icon(Icons.home), label: "Home"),
    DrawerItem(
      icon: Icon(Icons.person_outline),
      label: "Profile",
    ),
    DrawerItem(
        icon: Icon(
          Icons.shopping_cart,
        ),
        label: "Orders"),
    DrawerItem(
        icon: Icon(
          Icons.style,
        ),
        label: "Recipes"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFAB(),
      key: _scaffoldKey,
      drawer: CurvedDrawer(
        color: Colors.white,
        labelColor: Colors.black54,
        width: 72.0,
        items: _drawerItems,
        onTap: (newIndex) {
          setState(() {
            index = newIndex;
          });
          if (index == 0) {
          } else if (index == 2) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => OrderScreen()));
          } else if (index == 1) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ProfileScreen()));
          } else if (index == 3) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => RecipeScreen()));
          }
        },
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            buildHeader(),
            SizedBox(
              height: 30,
            ),
            BlocBuilder(
                builder: (BuildContext context, OffersState state) {
                  if (state is OffersInitial) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.green[400],
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
                          offer: offer,
                        );
                      }).toList(),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.green[400],
                      ),
                    );
                  }
                },
                bloc: _offersBloc),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      "Send message to receive \nneccessary items during lockdown",
                      style: TextStyle(
                        fontFamily: "Merriweather",
                        fontSize: 18,
                      ),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.green[400],
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => CustomMessage()));
                    },
                    child: Text("Place order",
                        style: TextStyle(
                            fontFamily: "Merriweather",
                            color: Colors.white,
                            fontSize: 18)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
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
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CategoryList(),
                  SizedBox(
                    height: 15,
                  ),
                  JoinUsCard(),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Text(
                "Best selling",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontFamily: "Merriweather",
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: ProductRepository().getRandomProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.green[400],
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
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (
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
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: LinearGradient(colors: [
                                          Colors.grey[100],
                                          Colors.grey[300]
                                        ], begin: Alignment.topRight)),
                                    child: Hero(
                                      tag: "${snapshot.data[index].sId}",
                                      child: Image.network(
                                        snapshot.data[index].imageurl,
                                        height: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      snapshot.data[index].name,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: "Merriweather",
                                          color: Colors.grey[700]),
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
                      backgroundColor: Colors.green[400],
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Text(
                "Custom Packs",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontFamily: "Merriweather",
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: PackRepo().getPacks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        height: 200,
                        // autoPlay: true,
                        // autoPlayInterval: Duration(seconds: 7),
                        // autoPlayAnimationDuration: Duration(milliseconds: 800),
                        // autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                      ),
                      items: snapshot.data.map<Widget>((pack) {
                        return PackCard(
                          pack: pack,
                        );
                      }).toList(),
                    );
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
            ),
            SizedBox(
              height: 80,
            ),
          ],
        ),
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
                  backgroundColor: Colors.green[400],
                ),
              );
            } else {
              return FloatingActionButton.extended(
                backgroundColor: Colors.green[400],
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => OrderScreen()));
                },
                label: Text(
                  "View Cart".toUpperCase(),
                  style: TextStyle(fontFamily: "Merriweather"),
                ),
                icon: Badge(
                    badgeColor: Colors.white,
                    child: Icon(Icons.shopping_basket),
                    badgeContent: Text(
                      "${snapshot.data.length}",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Merriweather",
                      ),
                    )),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green[400],
              ),
            );
          }
        });
  }

  Container buildHeader() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Hey ${widget.user.displayName.split(" ")[0]},",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      fontFamily: "Merriweather",
                      color: Colors.grey[700]),
                ),
              ),
              InkWell(
                  onTap: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    )),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 12, right: 20),
                      child: Icon(
                        Icons.menu,
                        size: 34,
                      ),
                    ),
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Find fresh products🍄🍉",
              style: TextStyle(
                  fontFamily: "Merriweather",
                  fontSize: 24,
                  color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}
