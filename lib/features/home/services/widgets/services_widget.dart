import 'package:bein_ecommerce/features/home/services/pages/subsub_category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ServicesWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  const ServicesWidget({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 0),
          Image.network(
            imagePath,
            height: 80,
            width: 80,
          ),
        ],
      ),
    );
  }
}
