import 'package:f2k/repos/PackRepo.dart';
import 'package:f2k/repos/model/Off.dart';
import 'package:f2k/repos/model/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OfferDetail extends StatefulWidget {
  final Off off;

  const OfferDetail({Key key, this.off}) : super(key: key);

  @override
  _OfferDetailState createState() => _OfferDetailState();
}

class _OfferDetailState extends State<OfferDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            widget.off.offerType,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: FutureBuilder(
            future: PackRepo().getPacks(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Container(
                    child: GridView.builder(
                  itemCount: snapshot.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    Product product = snapshot.data[index];
                    return Container(
                        child: Card(
                      child: new GridTile(
                        footer: new Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "${product.name} - ₹ ${product.price}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Merriweather",
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                product.imageurl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ), //just for testing, will fill with image later
                      ),
                    ));
                  },
                ));
              }
            }));
  }
}
