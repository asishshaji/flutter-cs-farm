part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class ProductLoadingEvent extends ProductsEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ProductStartEvent extends ProductsEvent {
  final String category;

  ProductStartEvent({@required this.category});

  @override
  // TODO: implement props
  List<Object> get props => [category];
}

class ProductRefreshEvent extends ProductsEvent {
  final String category;

  ProductRefreshEvent(this.category);

  @override
  // TODO: implement props
  List<Object> get props => [category];
}
