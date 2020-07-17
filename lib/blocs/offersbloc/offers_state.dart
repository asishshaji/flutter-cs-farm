part of 'offers_bloc.dart';

abstract class OffersState extends Equatable {
  const OffersState();
}

class OffersInitial extends OffersState {
  @override
  List<Object> get props => [];
}

class OffersLoadedState extends OffersState {
  final List<dynamic> loadedOffers;

  OffersLoadedState({this.loadedOffers});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
