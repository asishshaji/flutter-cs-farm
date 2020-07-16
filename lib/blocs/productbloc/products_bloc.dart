import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:f2k/repos/ProductRepo.dart';
import 'package:f2k/repos/model/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository _productRepository;
  ProductsBloc({ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductsInitialState());

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    if (event is ProductStartEvent) {
      List<dynamic> products =
          await _productRepository.getProductsByCategory(event.category);
      yield ProductLoadedState(loadedProducts: products);
    } else if (event is ProductLoadingEvent) {
      yield ProductLoadingState();
    }
  }
}
