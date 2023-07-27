import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FavoritesItem extends StatefulWidget {
  const FavoritesItem({super.key});

  @override
  State<FavoritesItem> createState() => _FavoritesItemState();
}

class _FavoritesItemState extends State<FavoritesItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 15.0, top: 10.0),
      child: SizedBox(
        width: double.infinity,
        height: 140,
        child: Stack(
          children: [
            PositionedDirectional(
              end: 0,
              start: 0,
              top: 0,
              bottom: 0,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 70),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // center the content horizontally
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // align the content to the start of the vertical axis
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          const Icon(
                            Icons.star_border_outlined,
                            color: Colors.yellow,
                            size: 25,
                          ),
                          Text(
                            '5.0',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                      Text(
                        'Dr - AbdElrahman Ashraf',
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
                            size: 25,
                          ),
                          Text(
                            'Dental & Dental Center ',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            PositionedDirectional(
              start: 1,
              bottom: 30,
              child: SizedBox(
                width: 80,
                height: 80,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(15.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/jcb_welcom_image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const PositionedDirectional(
              top: 15,
              end: 35,
              child: Icon(
                Icons.favorite,
                size: 25,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
