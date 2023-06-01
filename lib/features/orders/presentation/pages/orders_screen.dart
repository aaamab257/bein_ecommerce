import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:bein_ecommerce/features/orders/presentation/manager/myOrders_cubit.dart';
import 'package:bein_ecommerce/features/orders/presentation/manager/myOrders_state.dart';
import 'package:bein_ecommerce/features/orders/presentation/widgets/empty_orders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bein_ecommerce/di.dart' as di;
import '../../../../config/localization/app_localization.dart';
import '../../../../core/shared_widgets/error_widgts.dart';
import '../../../../core/shared_widgets/loading_screen.dart';
import '../../data/models/myOrders_model.dart';
import '../widgets/myOrders_page.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  List<MyOrderModel> myOrders = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<MyOrdersCubit>()..getMyOrders(),
      child: BlocConsumer<MyOrdersCubit, MyOrdersState>(
        listener: (context, state) => di.sl<MyOrdersCubit>(),
        builder: (context, state) {
          myOrders = MyOrdersCubit.get(context).myOrders;
          Widget _body() {
            if (state is MyOrdersLoading) {
              return const LoadingScreen();
            } else if (state is MyOrdersError) {
              return AppErrorWidget(
                onPress: () {
                  setState(() {});
                },
              );
            } else {
              return Scaffold(
                backgroundColor: ColorsManager.background,
                body: myOrders.isEmpty
                    ? const EmptyMyOrders()
                    : MyOrdersPage(
                        myOrdersList: myOrders,
                      ),
                appBar: AppBar(
                  backgroundColor: ColorsManager.background,
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    AppLocalizations.of(context)?.translate("my_orders") ??
                        "My_orders",
                  ),
                ),
              );
            }
          }

          return Scaffold(
            body: Container(
              child: _body(),
              color: ColorsManager.background,
            ),
            backgroundColor: ColorsManager.background,
          );
        },
      ),
    );
  }
}
