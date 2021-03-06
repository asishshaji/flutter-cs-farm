part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
}

class ProductsInitialState extends ProductsState {
  @override
  List<Object> get props => [];
}

class ProductLoadingState extends ProductsState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ProductLoadedState extends ProductsState {
  final List<dynamic> loadedProducts;

  ProductLoadedState({this.loadedProducts});

  @override
  // TODO: implement props
  List<Object> get props => [loadedProducts];
}

class ProductRefreshedState extends ProductsState {
  final List<dynamic> loadedProducts;

  ProductRefreshedState({this.loadedProducts});

  @override
  // TODO: implement props
  List<Object> get props => [loadedProducts];
}

class ProductLoadingFailedState extends ProductsState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class GetRandomProductStateStarted extends ProductsState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class GetRandomProductStateFinished extends ProductsState {
  final List<dynamic> loadedProducts;

  GetRandomProductStateFinished(this.loadedProducts);

  @override
  // TODO: implement props
  List<Object> get props => [loadedProducts];
}
