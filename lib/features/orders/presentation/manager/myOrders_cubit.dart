import 'package:bein_ecommerce/features/orders/data/models/myOrders_model.dart';
import 'package:bein_ecommerce/features/orders/presentation/manager/myOrders_state.dart';
import 'package:bein_ecommerce/features/user/auth/login/presentation/manager/login_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bein_ecommerce/di.dart' as di;
import '../../domain/use_cases/my_orders_use_case.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  final MyOrdersUseCase myOrdersUseCase;

  MyOrdersCubit({
    required this.myOrdersUseCase,
  }) : super(MyOrdersInitial());

  static MyOrdersCubit get(context) => BlocProvider.of(context);
  List<MyOrderModel> myOrderModel = [];

  List<MyOrderModel> get myOrders => myOrderModel ;

  Future<List<MyOrderModel>> getMyOrders() async {
    emit(MyOrdersLoading());
    String token ="" ;
    await di.sl<LoginCubit>().getToken().then((value){
      token = value ;
    });
    (await myOrdersUseCase.getMyOrders(token)).fold((failure) {

      emit(MyOrdersError());
    }, (myOrders) {
      myOrderModel = myOrders;

      emit(MyOrdersSuccess());
    });

    return myOrderModel;
  }
}
