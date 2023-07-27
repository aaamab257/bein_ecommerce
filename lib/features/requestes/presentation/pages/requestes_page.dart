import 'package:bein_ecommerce/config/localization/app_localization.dart';
import 'package:bein_ecommerce/features/requestes/presentation/widgets/current_requestes.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class RequestesScreen extends StatefulWidget {
  const RequestesScreen({super.key});

  @override
  State<RequestesScreen> createState() => _RequestesScreenState();
}

class _RequestesScreenState extends State<RequestesScreen>
    with SingleTickerProviderStateMixin {
  var _tabController;
  final List<Tab> tabs = <Tab>[];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_outlined),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.0),
                  ),
                ),
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                      ],
                    ),
                  );
                },
              );
            },
          )
        ],
        automaticallyImplyLeading: false,
        title: Text(
            AppLocalizations.of(context)!.translate('requests') ?? "Requests"),
        elevation: 0.5,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.all(15.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    text: AppLocalizations.of(context)!.translate('req_tab1') ??
                        "Current",
                  ),
                  Tab(
                    text: AppLocalizations.of(context)!.translate('req_tab2') ??
                        "Previous",
                  ),
                ],
                labelStyle: Theme.of(context).textTheme.headlineSmall,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Theme.of(context).accentColor,
                indicatorColor: const Color(0xff88489E),
                indicator: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(8.0),
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  child: SizedBox(
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return  CurrentRequeste(title : "تحت الطلب");
                      },
                    ),
                  ),
                ),
                Container(
                  child: SizedBox(
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return  CurrentRequeste(title : "انتهت");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
