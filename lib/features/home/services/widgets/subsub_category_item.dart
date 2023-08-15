import 'package:bein_ecommerce/features/home/services/pages/installment_request_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SubSubCategoryItem extends StatefulWidget {
  String name;
  int id;
  String price;
  String desc;
  SubSubCategoryItem(
      {super.key,
      required this.id,
      required this.name,
      required this.price,
      required this.desc});

  @override
  State<SubSubCategoryItem> createState() => _SubSubCategoryItemState();
}

class _SubSubCategoryItemState extends State<SubSubCategoryItem> {
  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const InstallmentRequestScreen()),
        );
      },
      child: Stack(
        children: [
          PositionedDirectional(
            start: 0,
            end: 0,
            top: 40,
            bottom: 0,
            child: SizedBox(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          const Icon(
                            Icons.star_border_outlined,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          Text(
                            '5.0',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                      Text(
                        widget.desc,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          Text(
                            widget.name,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          PositionedDirectional(
            top: -5,
            start: 20,
            end: 20,
            child: SizedBox(
              height: 100,
              child: Stack(
                children: [
                  PositionedDirectional(
                    top: 0,
                    end: 0,
                    start: 0,
                    bottom: 0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          'assets/images/jcb_walkthrough1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: 0,
                    end: 23,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.7),
                        border: Border.all(color: Colors.transparent),
                        borderRadius: const BorderRadiusDirectional.only(
                            bottomStart: Radius.circular(25),
                            topEnd: Radius.circular(28)),
                      ),
                      child: Center(
                        child: IconButton(
                          icon: _isFavorited
                              ? Icon(Icons.favorite)
                              : Icon(Icons.favorite_border),
                          color: Colors.red,
                          onPressed: _toggleFavorite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
