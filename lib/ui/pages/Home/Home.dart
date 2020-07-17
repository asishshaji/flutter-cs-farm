import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_drawer/curved_drawer.dart';
import 'package:f2k/blocs/offersbloc/offers_bloc.dart';
import 'package:f2k/blocs/productbloc/products_bloc.dart';
import 'package:f2k/ui/pages/Home/CategoryList.dart';
import 'package:f2k/ui/pages/Home/offer_banner.dart';
import 'package:f2k/ui/pages/Orders.dart';
import 'package:f2k/ui/pages/Profile.dart';
import 'package:f2k/ui/pages/RecipeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    // TODO: implement initState
    super.initState();
    _productsBloc = BlocProvider.of<ProductsBloc>(context);
    _offersBloc = BlocProvider.of<OffersBloc>(context);
    _offersBloc.add(GetOffers());
    _productsBloc.add(ProductStartEvent(category: "Vegetable"));
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
    DrawerItem(
        icon: Icon(
          Icons.notifications_none,
        ),
        label: "Notifications"),
    DrawerItem(
        icon: Icon(
          Icons.style,
        ),
        label: "Recipes"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green[400],
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => OrderScreen()));
        },
        label: Text(
          "View Cart".toUpperCase(),
          style: TextStyle(fontFamily: "Merriweather"),
        ),
        icon: Icon(Icons.shopping_basket),
      ),
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
                        InkWell(
                            onTap: () {
                              _scaffoldKey.currentState.openDrawer();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(
                                Icons.menu,
                                size: 34,
                              ),
                            )),
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
                        height: 300,
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
      ),
    );
  }
}
