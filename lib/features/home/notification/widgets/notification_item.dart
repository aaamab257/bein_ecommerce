import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NotificationItem extends StatefulWidget {
  const NotificationItem({super.key});

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 160,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 0.5,
        child: Stack(
          children: [
            PositionedDirectional(
              bottom: 0,
              top: 32,
              start: 0,
              end: 0,
              child: Padding(
                padding: const EdgeInsetsDirectional.all(10.0),
                child: Container(
                  child: Text(
                    'انتظر مكالمة من فريق سنيار في خلال 48 ساعة لمزيدمن الاستفسارات تواصل معنا علي 15864',
                    style: Theme.of(context).textTheme.headlineSmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
            ),
            PositionedDirectional(
              top: 0,
              start: 0,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 10.0, end: 5.0, top: 5.0, bottom: 10.0),
                child: Container(
                  child: Text(
                    'تم تقديم طلب التقسيط بنجاح',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
            ),
            PositionedDirectional(
              bottom: 0,
              start: 0,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 10.0, end: 5.0, top: 5.0, bottom: 10.0),
                child: Container(
                  child: Text(
                    '18 / 7 / 2023 10:45 AM',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
            ),
            PositionedDirectional(
              top: 0,
              end: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFA5CD39),
                  border: Border.all(color: Colors.transparent),
                  borderRadius: const BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(25),
                    topEnd: Radius.circular(25),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Requests',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
