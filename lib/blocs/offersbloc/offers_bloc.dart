import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:f2k/repos/OffersRepo.dart';
import 'package:f2k/repos/model/Offers.dart';

part 'offers_event.dart';
part 'offers_state.dart';

class OffersBloc extends Bloc<OffersEvent, OffersState> {
  final OffersRepo _repo;
  OffersBloc({OffersRepo repo})
      : _repo = repo,
        super(OffersInitial());

  @override
  Stream<OffersState> mapEventToState(
    OffersEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is GetOffers) {
      List<Offer> offers = await _repo.getOffer();

      yield OffersLoadedState(loadedOffers: offers);
    }
  }
}
