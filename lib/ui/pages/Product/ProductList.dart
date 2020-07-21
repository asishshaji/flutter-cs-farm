import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:f2k/blocs/productbloc/products_bloc.dart';
import 'package:f2k/repos/model/Product.dart';
import 'package:f2k/ui/pages/Product/ProductDetail.dart';
import 'package:f2k/ui/pages/Sorry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductListScreen extends StatefulWidget {
  final String category;

  const ProductListScreen({Key key, this.category}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductsBloc _productsBloc;
  List<dynamic> products = List<dynamic>();

  @override
  void initState() {
    super.initState();
    _productsBloc = BlocProvider.of<ProductsBloc>(context);
    _productsBloc.add(ProductLoadingEvent());
    _productsBloc.add(ProductStartEvent(category: widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Container(
          height: 65,
          width: 65,
          child: FloatingActionButton(
            child: Icon(
              Icons.refresh,
              size: 26,
            ),
            backgroundColor: Colors.green[400],
            onPressed: () {
              _productsBloc.add(ProductRefreshEvent(widget.category));
            },
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey[700],
            ),
          ),
          title: Text(
            widget.category,
            style: TextStyle(
                fontFamily: "Merriweather",
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
        ),
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (BuildContext context, ProductsState state) {
            if (state is ProductLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.green[400],
                ),
              );
            } else if (state is ProductLoadedState) {
              products.clear();
              products = state.loadedProducts;
              if (products.length == 0) return ErrorSorry(msg: "Coming Soon");
              return buildStaggeredGridView(products);
            } else if (state is ProductRefreshedState) {
              products.clear();
              products = state.loadedProducts;
              return buildStaggeredGridView(products);
            }
          },
          bloc: _productsBloc,
        ));
  }

  Future<void> _handleRefresh() async {
    _productsBloc.add(ProductRefreshEvent(widget.category));
  }

  StaggeredGridView buildStaggeredGridView(List<dynamic> products) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: products.length,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      itemBuilder: (BuildContext context, int index) =>
          buildProductCard(products[index]),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(1, index.isEven ? 1.3 : 1.2),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
    );
  }

  InkWell buildProductCard(Product product) {
    return InkWell(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (
          BuildContext context,
        ) {
          return ProductDetailScreen(product: product);
        }));
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: "${product.sId}",
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.grey[600],
                      Colors.grey[700],
                      Colors.grey[600],
                    ]).createShader(bounds);
              },
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 4,
                child: CachedNetworkImage(
                    imageUrl: product.imageurl,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  backgroundColor: Colors.green[400],
                                  value: downloadProgress.progress),
                            )),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              product.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: "Merriweather"),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 10,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 20),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "₹ ${product.price}",
                  style: TextStyle(
                      fontFamily: "Merriweather",
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
