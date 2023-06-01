import 'package:bein_ecommerce/config/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/shared_widgets/components.dart';
import '../../../../../data/data.dart';
import '../../../search/presentation/pages/search_view.dart';

class MarksView extends StatelessWidget {
  final double width;
  const MarksView({Key? key, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width ;
    return Column(
      children: [
        SizedBox(
                width: w * 0.95,
                child: TitleSection(
                  text: AppLocalizations.of(context)!.translate("mostPopular")
                      ?? "Most_Popular",
                  isViewMore: true,
                )
            ),
            const SizedBox(height: 20),
        Container(
          width: width,
          margin: const EdgeInsets.only(left: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: [
                  /* const SearchView(), */
              ...List.generate(
                
                brandes.length,
                (index) =>
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(brandes[index]["image"]),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        brandes[index]["lable"],
                        style: const TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ],
    );

  }
}
