import 'dart:convert';

import 'package:bein_ecommerce/core/utils/assets_manager/img_manger.dart';
import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:bein_ecommerce/features/home/main-pages/home_screen.dart';
import 'package:bein_ecommerce/features/home/main-pages/main_screen.dart';
import 'package:bein_ecommerce/features/on_boarding/domain/entities/countries_entity.dart';
import 'package:bein_ecommerce/features/on_boarding/presentation/pages/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_splash/flutter_animated_splash.dart'
    as transition;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../on_boarding/data/models/country.dart';
import '../../../../on_boarding/presentation/manager/countries_cubit.dart';
import 'package:bein_ecommerce/di.dart' as di;

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({Key? key}) : super(key: key);

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {

  var country;
  @override
  void initState() {
    super.initState();


    di
        .sl<CountriesCubit>()
        .getCurrentCountry()
        .then((value) => country = value);
  }

  @override
  Widget build(BuildContext context) {
    bool isFirstTime = false;

    return BlocProvider(
      create: (context) => di.sl<CountriesCubit>()..getCurrentCountry(),
      child: BlocConsumer<CountriesCubit, CountriesState>(
          listener: (context, state) => di.sl<CountriesCubit>(),
          builder: (context, state) {
            return transition.AnimatedSplash(
                type: transition.Transition.fade,
                curve: Curves.bounceIn,
                backgroundColor: ColorsManager.splashBackground,
                navigator: country == null
                    ? OnBoardingScreen(
                        pages: [
                          OnBoardingModel(
                            title: 'Justo lacus detraxit posuere lobortis.re',
                            description:
                                'consul mel offendit doctus graeci per veniam tincidunt referrentur natum recteque sit graeco nonumy ornatus definitiones varius fermentum vel vix sea augue ei cu ornatus quaeque suscipit necessitatibus tempus tellus ridiculus ludus congue tamquam mucius mediocrem latine dolorum consectetuer delicata taciti inciderint omittam litora adhuc mea mauris convenire aliquet viverra ludus malorum cetero nominavi tincidunt senectus ultricies error tacimates simul movet sanctus no putent signiferumque malorum verear litora adversarium delicata conubia quis suavitate neque his quaeque civibus senectus error atomorum dico dicat honestatis platonem aptent eirmod porta nascetur eget curabitur doctus ancillae proin fringilla malesuada tempus vulputate ubique efficiantur quidam repudiare graeci voluptaria dico habitant pericula mutat libero definitiones ponderum ubique his conclusionemque solum fastidii eros mentitum pri legere pri eloquentiam oporteat affert sententiae cum tellus fastidii orci nihil placerat deseruisse quot tortor an adipisci idque conclusionemque inceptos lacus nihil pharetra duo malorum consectetuer utinam singulis porta audire sociis convallis dissentiunt aptent petentium dis accumsan fugit dolor donec dictas maluisset amet est splendide reprehendunt consetetur consectetuer assueverit tritani id animal moderatius movet lorem congue inani nostrum imperdiet feugiat his mazim invidunt voluptaria a accusata voluptaria intellegebat verear varius tantas aeque persius ius mutat feugiat animal ad meliore solet duis ultricies consetetur agam varius vituperatoribus iaculis id ludus dolorum adversarium suspendisse maiorum option movet in malesuada pulvinar movet sonet curae dictas interesset lobortis donec necessitatibus a nibh epicurei unum graeco tibique evertitur minim ferri mauris massa ante pri solum legimus porta movet gubergren salutatus turpis cetero viverra aliquet suspendisse nonumes morbi melius penatibus signiferumque suscipiantur fastidii equidem mei senectus fuisset appareat mattis malesuada option at fastidii equidem molestiae vitae recteque causae venenatis massa justo vero nec simul graece fusce his ut dis dicam mentitum velit fabulas doctus deterruisset harum vivamus ac mel sit quod conclusionemque quaestio tempus vim constituto placerat sagittis elaboraret est convallis epicuri etiam dicam quam conceptam viverra alterum omittantur et error nibh appareat meliore ubique congue propriae noster placerat reformidans eros sapientem quot aliquip epicuri numquam splendide donec risus arcu eripuit sagittis feugiat persecuti nominavi veri iudicabit alterum rhoncus aptent aperiri reque homero ex fabulas vidisse eum proin sadipscing ullamcorper consequat feugait aliquam expetenda scelerisque contentiones dicit quo sea sit wisi blandit imperdiet potenti mandamus nostra interpretaris tristique sed vituperatoribus aenean constituam congue expetendis tation explicari tortor aliquam consul moderatius agam reprehendunt agam eros saepe percipit atomorum fugit instructior vix quaerendum decore finibus tempus mea mnesarchum varius atomorum',
                            image: 'assets/image0.png',
                            bgColor: Colors.indigo,
                          ),
                          OnBoardingModel(
                            title:
                                'dolorem sit decore animal his nam alia alia velit unum',
                            description:
                                'falli mel signiferumque evertitur maiorum eripuit per repudiandae partiendo consequat bibendum et dictumst maecenas molestie posse idque duis liber placerat veritus efficiantur altera accusata venenatis nam suas dicta verterem efficiantur quot alia montes dico mazim posuere tractatos primis esse dicat appetere ornatus nunc molestiae cetero pericula vel ornatus dictas velit',
                            image: 'assets/image1.png',
                            bgColor: const Color(0xff1eb090),
                          ),
                          OnBoardingModel(
                            title:
                                'iaculis blandit gloriatur corrumpit legimus lorem dignissim tortor urna maiorum',
                            description:
                                'sociis eros perpetua rutrum blandit sapientem morbi mel ultrices mnesarchum eum error iriure risus sea veniam inani prompta nascetur brute tale feugiat ultricies eget graeci iudicabit feugait dissentiunt explicari voluptatibus tincidunt elementum verear explicari inimicus nominavi dis volutpat curabitur ornatus disputationi ex tota legere eget ultrices cu mazim mentitum scripta',
                            image: 'assets/image2.png',
                            bgColor: const Color(0xfffeae4f),
                          ),
                          OnBoardingModel(
                            title:
                                'propriae sociosqu per utroque inceptos netus tincidunt verterem usu purus',
                            description:
                                'pro wisi affert fabellas omittantur qui nulla porta autem contentiones netus cu nominavi torquent fusce justo postulant periculis dico dicit dolores mauris mea rutrum ubique euripidis nominavi nec laudem enim nullam appareat reprimique libero quo bibendum tristique maluisset gravida hendrerit ancillae intellegat ut cum nonumy moderatius odio recteque porta sagittis',
                            image: 'assets/image3.png',
                            bgColor: Colors.purple,
                          ),
                        ],
                      )
                    : const MainScreen(),
                durationInSeconds: 3,
                child: Image.asset(
                  ImagesManager.appIcon,
                  width: 100.h,
                  height: 100.h,
                ));
          }),
    );
  }
}

/*  */
