import 'package:bein_ecommerce/core/api/end_points.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../products/data/models/slider_model.dart';
import '../../../products/domain/use_cases/get_all_products.dart';

import 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  final GetAllProductsUseCase getAllProductsUseCase;

  OffersCubit({
    required this.getAllProductsUseCase,
  }) : super(OffersInitial());

  static OffersCubit get(context) => BlocProvider.of(context);

  List<Imgs> get getOffer => offersModel;

  List<Imgs> offersModel = [];
  List<Widget> imgs = [];



  Future<List<Imgs>> getOffers() async {
    emit(OffersLoading());
    (await getAllProductsUseCase.getOffers()).fold((failure) {
      debugPrint("uuuuuuuuuuu" + failure.toString());
      emit(OffersError());
    }, (offers) {
      debugPrint(offers.toString());
      // offersModel = offers;
      for (var offer in offers) {
        imgs.add(ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Image.network(
            '${EndPoints.BASE_URL2}${offer.url!}',
            fit: BoxFit.cover,
            
          ),
        ));
      }
      emit(OffersSuccess());
    });
    return offersModel;
  }
}
