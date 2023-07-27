import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bein_ecommerce/di.dart' as di;
import '../../../../../config/localization/app_localization.dart';
import '../../../../../core/shared_widgets/error_widgts.dart';
import '../../../../../core/shared_widgets/loading_screen.dart';
import '../../../../cart/presentation/manager/cart_cubit.dart';
import '../../../../cart/presentation/manager/cart_state.dart';
import '../widgets/checkout_body.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<String> payType = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<CartCubit>()..getPayType(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: Text(AppLocalizations.of(context)!.translate("checkout") ??
                "Checkout"),
            centerTitle: true,

          ),

          body: Container(
            child: BlocConsumer<CartCubit, CartState>(
                listener: (context, state) => di.sl<CartCubit>(),
                builder: (context, state) {
                  payType = CartCubit.get(context).payType;
                  if (state is CartLoading) {
                    return const LoadingScreen();
                  } else if (state is CartError) {
                    return AppErrorWidget(
                      onPress: () {
                        setState(() {});

                      },
                    );
                  } else {
                    return CheckoutBody(
                      payType: payType,
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
/**/
}
