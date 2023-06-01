import 'package:bein_ecommerce/core/utils/colors/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../../../config/localization/app_localization.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsManager.background,
        appBar: buildPreferredSize(context),

      ),
        );

        
  }
PreferredSize buildPreferredSize(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(double.infinity, 100),
      child: Container(
        margin: EdgeInsets.all(10),
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
            hintText: AppLocalizations.of(context)!.translate("search")??"Search",
          ),
        ),
      ),
       
    );
  }
  
  
}


