import 'package:bein_ecommerce/config/localization/app_localization.dart';
import 'package:bein_ecommerce/config/route/app_routes.dart';
import 'package:bein_ecommerce/core/shared_pref/app_prefs.dart';
import 'package:bein_ecommerce/core/shared_widgets/app_toasts.dart';
import 'package:bein_ecommerce/core/shared_widgets/error_widgts.dart';
import 'package:bein_ecommerce/core/shared_widgets/loading_screen.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:bein_ecommerce/features/on_boarding/presentation/manager/countries_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bein_ecommerce/di.dart' as di;
import '../../domain/entities/countries_entity.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({Key? key}) : super(key: key);

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  var cubit = di.sl<CountriesCubit>();
  List<CountryEntity> countries = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<CountriesCubit>()..getCountries(),
      child: BlocConsumer<CountriesCubit, CountriesState>(
        listener: (context, state) => cubit,
        builder: (context, state) {
          countries = CountriesCubit.get(context).countries;
          Widget _body1() {
            if (state is CountriesLoading) {
              return const LoadingScreen();
            } else if (state is CountriesError) {
              return AppErrorWidget(
                onPress: () {
                  setState(() {});
                },
              );
            } else {
              return CountriesSelection(
                countries: countries,
              );
            }
          }

          return Scaffold(
            backgroundColor: ColorsManager.background,
            appBar: AppBar(
              backgroundColor: ColorsManager.background,
            ),
            body: _body1(),
          );
        },
      ),
    );
  }
}

class CountriesSelection extends StatefulWidget {
  final List<CountryEntity> countries;
  const CountriesSelection({
    super.key,
    required this.countries,
  });

  @override
  State<CountriesSelection> createState() => _CountriesSelectionState();
}

class _CountriesSelectionState extends State<CountriesSelection> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          /* gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 1),
          colors: <Color>[
            ColorsManager.orange,
            ColorsManager.background,
          ],
          tileMode: TileMode.mirror,
        ), */
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 450.h,
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Text(AppLocalizations.of(context)!
                                      .translate("selectCountry") ??
                                  "select country"),
                              const Divider(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 300.h,
                          child: ListView(
                            children: List.generate(
                              widget.countries.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: ListTile(
                                    tileColor: ColorsManager.background,
                                    selectedColor: ColorsManager.white,
                                    selectedTileColor: const Color(0xff064A7B),
                                    selected: currentIndex == index,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    title: widget.countries.isNotEmpty
                                        ? Text(widget.countries[index].name)
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xff064A7B) // Background color
                            ),
                            onPressed: () async {
                              print('current country ==============================444444===================================== > ${widget.countries[currentIndex].name}');
                              di
                                  .sl<CountriesCubit>()
                                  .saveCountrySelectionToLocalDB(
                                      widget.countries[currentIndex])
                                  .then((value) {
                                if (value) {
                                  di.sl<AppPreferences>().setShowCountries();
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      AppRouteName.home, (route) => false);
                                } else {
                                  AppToasts.errorDialog(context: context);
                                }
                              });
                            },
                            child: const Icon(Icons.arrow_forward_sharp))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
