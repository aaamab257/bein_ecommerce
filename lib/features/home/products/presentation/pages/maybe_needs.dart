import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../categories/presentation/pages/sub_category_page.dart';
import '../../../services/widgets/services_widget.dart';

class MaybeNeeds extends StatefulWidget {
  const MaybeNeeds({super.key});

  @override
  State<MaybeNeeds> createState() => _MaybeNeedsState();
}

class _MaybeNeedsState extends State<MaybeNeeds> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            itemCount: 3,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.0,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5,
              mainAxisExtent: 135,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                             SubCategoryScreen(id: 1,),
                        transitionDuration: const Duration(seconds: 1),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          final tween = Tween(begin: begin, end: end);
                          final offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        }),
                  );
                },
                child: const ServicesWidget(
                    title: 'Test', imagePath: 'assets/image0.png'),
              );
            }));
  }
}
