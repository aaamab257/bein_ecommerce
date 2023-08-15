import 'package:bein_ecommerce/config/route/app_routes.dart';
import 'package:bein_ecommerce/core/shared_widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../config/localization/app_localization.dart';

class IntrestedScreen extends StatefulWidget {
  const IntrestedScreen({super.key});

  @override
  State<IntrestedScreen> createState() => _IntrestedScreenState();
}

class _IntrestedScreenState extends State<IntrestedScreen> {
  Set<int> _selectedIndices = Set<int>();

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsetsDirectional.only(start: 16.0, end: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
              child: Text(
                AppLocalizations.of(context)!.translate('choose_intrested') ??
                    "choose_intrested",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
              child: Text(
                AppLocalizations.of(context)!
                        .translate('choose_from_intresing') ??
                    "choose_from_intresing",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 5,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 3.0,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 10,
                mainAxisExtent: 80,
              ),
              itemBuilder: (context, index) {
                bool isSelected = _selectedIndices.contains(index);
                return GestureDetector(
                  onTap: () => _toggleSelection(index),
                  child: Card(
                    elevation: 3.0,
                    color: isSelected ? const Color(0xff6D2D83) : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Container(
                          child: Text('Services',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Cairo',
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xff6D2D83)))),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
              child: AppButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouteName.home);
                  },
                  buttonTxt:
                      AppLocalizations.of(context)!.translate('start_now') ??
                          "Start"),
            )
          ],
        ),
      ),
    );
  }
}
