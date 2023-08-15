
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../services/pages/subsub_category_page.dart';
import '../../data/models/sub_category_model.dart';

class SubCategoryItem extends StatefulWidget {
  int id ; 
  String name ;
  List<Product> products ;
  SubCategoryItem({ required this.products, required this.id , required this.name});

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
          MaterialPageRoute(builder: (context) => SubSubCategoryPage(products: widget.products,)),
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
          child: Text(widget.name,style: Theme.of(context).textTheme.bodyLarge,),
        ),
      ),
    );
  }
}
