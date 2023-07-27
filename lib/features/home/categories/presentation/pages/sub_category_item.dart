import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../services/pages/subsub_category_page.dart';

class SubCategoryItem extends StatefulWidget {
  const SubCategoryItem({super.key});

  @override
  State<SubCategoryItem> createState() => _SubCategoryItemState();
}

class _SubCategoryItemState extends State<SubCategoryItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SubSubCategoryPage()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(15.0),
          image: const DecorationImage(
            image: AssetImage('assets/images/jcb_welcom_image.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text('Dental',style: Theme.of(context).textTheme.bodyLarge,),
        ),
      ),
    );
  }
}
