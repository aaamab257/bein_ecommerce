import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/localization/app_localization.dart';
import '../../config/route/app_routes.dart';
import '../../features/splash/presentation/localization/local_bloc/local_cubit.dart';
import '../utils/colors/colors_manager.dart';

class AppBottomNavBar extends StatefulWidget {

  final List iconList ;
  
  const AppBottomNavBar({Key? key, required this.iconList }) : super(key: key);

  @override
  State<AppBottomNavBar> createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar> {
  int currentIndexBottomBar = 0 ;
  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      height: 60.h,
      itemCount: widget.iconList.length,
      tabBuilder: (int index, bool isActive) {
        const color =  Colors.white;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Icon(
              widget.iconList[index],
              size: 24,
              color: color,
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                index == 0
                    ? AppLocalizations.of(context)?.translate("language") ??"Language"
                    : index == 1
                    ? AppLocalizations.of(context)?.translate("cart") ?? "Cart"
                    : index == 2
                    ? AppLocalizations.of(context)?.translate("account") ??"Account"
                    :AppLocalizations.of(context)?.translate("settings") ?? "Settings",
                maxLines: 1,
                style: TextStyle(color: color , fontSize: 15.sp),
              ),
            )
          ],
        );
      },
      backgroundColor: ColorsManager.black,
      activeIndex: currentIndexBottomBar,
      splashColor: ColorsManager.orange,
      splashSpeedInMilliseconds: 300,
      notchSmoothness: NotchSmoothness.softEdge,
      gapLocation: GapLocation.center,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      
      onTap: (index) {
        setState(() => currentIndexBottomBar = index);
        switch(index){
          case 0 :
          AppLocalizations.of(context)!.isEnLocale
              ? LocaleCubit.get(context).toArabic()
              : LocaleCubit.get(context).toEnglish();
              break;
              case 2 :
              index == 2 ?
              Navigator.pushNamedAndRemoveUntil(context, AppRouteName.account,(route) => false) : index = 2 ;
              break ;
            
        }
        if(index == 0){
          
        }
      },
    );
  }
}
