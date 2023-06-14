import 'package:bein_ecommerce/config/localization/app_localization.dart';
import 'package:bein_ecommerce/config/route/app_routes.dart';
import 'package:bein_ecommerce/core/api/end_points.dart';
import 'package:bein_ecommerce/core/shared_widgets/outline_button.dart';
import 'package:bein_ecommerce/core/shared_widgets/solid_button.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:bein_ecommerce/features/user/auth/login/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:bein_ecommerce/di.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/shared_widgets/bottom_nav_bar.dart';
import '../../../../../core/shared_widgets/error_widgts.dart';
import '../../../../../core/shared_widgets/loading_screen.dart';
import '../../../../home/products/data/data_sources/remote_data_source/all_products_remote_data_source.dart';
import '../../../auth/login/presentation/manager/login_cubit.dart';
import '../../../auth/login/presentation/manager/login_state.dart';
import '../widgets/gest_profile.dart';
import '../widgets/logged_profile.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  /*final channel = IOWebSocketChannel.connect('${EndPoints.BASE_URL}/ws');*/

  bool _isLogged = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    di.sl<LoginCubit>().getToken().then((value) {
      if (value.isEmpty) {
        setState(() {
          _isLogged = false;
        });
      } else {
        setState(() {
          _isLogged = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => di.sl<LoginCubit>(),
        child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) => di.sl<LoginCubit>(),
            builder: (context, state) {
              Widget body() {
                if (state is LoginLoading) {
                  return const LoadingScreen();
                } else if (state is LoginError) {
                  return AppErrorWidget(
                    onPress: () {
                      setState(() {});
                    },
                  );
                } else {
                  return SafeArea(
                    child: Scaffold(


                        body: _isLogged
                            ? const LoggedProfile()
                            : const GestProfile()),
                  );
                }
              }

              return SafeArea(
                child: Scaffold(

                  body: Container(
                    child: body(),

                  ),
                ),
              );
            })); /**/
  }
}
