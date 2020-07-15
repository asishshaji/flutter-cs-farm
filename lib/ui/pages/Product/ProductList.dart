import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:f2k/blocs/productbloc/products_bloc.dart';
import 'package:f2k/repos/model/Product.dart';
import 'package:f2k/ui/pages/Product/ProductDetail.dart';

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
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (BuildContext context, ProductsState state) {
            if (state is ProductLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is ProductLoadedState) {
              List<Product> products = state.loadedProducts;
              return buildStaggeredGridView(products);
            }
          },
          bloc: _productsBloc,
        ));
  }

  StaggeredGridView buildStaggeredGridView(List<Product> products) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: products.length,
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
      itemBuilder: (BuildContext context, int index) => OpenContainer(
        closedElevation: 6.0,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        transitionType: ContainerTransitionType.fade,
        transitionDuration: const Duration(milliseconds: 500),
        openBuilder: (context, action) {
          return ProductDetailScreen(
            imageurl:
                "https://images.unsplash.com/photo-1594397606420-a132b153ff04?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=40",
          );
        },
        closedBuilder: (context, action) {
          return buildProductCard(products[index]);
        },
      ),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(1, index.isEven ? 1.4 : 1.3),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
    );
  }

  Stack buildProductCard(Product product) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.black,
                    Colors.grey[200],
                    Colors.grey[700]
                  ]).createShader(bounds);
            },
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.network(
                "https://images.unsplash.com/photo-1594397606420-a132b153ff04?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=40",
                fit: BoxFit.fill,
                width: double.infinity,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
            )),
        Align(
          alignment: Alignment.center,
          child: Text(
            product.name,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, fontFamily: "Merriweather", color: Colors.white),
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
                product.price,
                style: TextStyle(
                    fontFamily: "Merriweather",
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        )
      ],
    );
  }
}
