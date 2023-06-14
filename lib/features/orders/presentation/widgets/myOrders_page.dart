import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/colors/colors_manager.dart';
import '../../data/models/myOrders_model.dart';

class MyOrdersPage extends StatefulWidget {
  final List<MyOrderModel> myOrdersList;

  const MyOrdersPage({required this.myOrdersList, Key? key}) : super(key: key);

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  @override
  Widget build(BuildContext context) {
    print('OrdersList len =====================> ${widget.myOrdersList.length}');
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(5.0),
              itemCount: widget.myOrdersList.length,
              itemBuilder: (context, index) {

                /*DateTime tempDate =  DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
                String formatedDate = DateFormat("yyyy-MM-dd hh:mm").format(tempDate);*/
                return Card(
                    elevation: 5.0,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        leading: Container(
                          padding: const EdgeInsets.only(right: 12.0),
                          decoration: const BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      width: 1.0, color: Colors.white24))),
                          child: const Icon(Icons.list_rounded,
                              ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.myOrdersList[index].orderItem!.length} Products ',
                              style: const TextStyle(

                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            /*Text(

                              widget.myOrdersList[index].orderItem![index]
                                  .orderItemProduct!.createdDate!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),*/
                          ],
                        ),
                        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                        subtitle: Row(
                          children: [
                            Text(
                                widget.myOrdersList[index].orderStatus!,
                                style: const TextStyle(color: Colors.white)),
                            const Spacer(),
                            Text(
                              widget.myOrdersList[index].payType!,
                              style: const TextStyle(color: Colors.white),
                            )
                          ],
                        ),

                      ),
                    ));
              }),
        ],
      ),
    );
  }
}
