import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../../config/localization/app_localization.dart';
import '../../../../core/shared_widgets/app_button.dart';
import '../../../../core/shared_widgets/text_field.dart';
import '../../../requestes/presentation/pages/request_details.dart';

class InstallmentRequestScreen extends StatefulWidget {
  const InstallmentRequestScreen({super.key});

  @override
  State<InstallmentRequestScreen> createState() =>
      _InstallmentRequestScreenState();
}

class _InstallmentRequestScreenState extends State<InstallmentRequestScreen> {
  Set<int> _selectedIndices = Set<int>();
  TextEditingController _depositCont = TextEditingController();

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text(
          'Dental',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 15.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 120,
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
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 70),
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
                                    size: 20,
                                  ),
                                  Text(
                                    '5.0',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    'Dental & Dental Center ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
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
                      bottom: 20,
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(15.0),
                            image: const DecorationImage(
                              image: AssetImage(
                                  'assets/images/jcb_welcom_image.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Details',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'زراعة أسنان فورية بعد الخلع مباشرة مع تركيبة زركونيا',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Deposit',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Divider(),
                  CustomTextField(
                    controller: _depositCont,
                    hint: AppLocalizations.of(context)?.translate("0") ?? "0",
                    type: TextInputType.number,
                    isPassword: false,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'خطط التقسيط',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Divider(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 170,
                child: ListView.builder(
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    bool isSelected = _selectedIndices.contains(index);
                    return _installmentPlans('6', index, isSelected);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: AppButton(
                  buttonTxt:
                      AppLocalizations.of(context)!.translate('installment') ??
                          "Installment",
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _installmentPlans(String title, int index, bool isSelected) {
    return GestureDetector(
        onTap: () => _toggleSelection(index),
        child: Container(
            width: 150,
            padding: const EdgeInsets.all(15.0),
            margin: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                color: isSelected ? const Color(0xff6D2D83) : Colors.white,
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      color:
                          isSelected ? Colors.white : const Color(0xff6D2D83),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    '$title Months',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Cairo',
                      color:
                          isSelected ? Colors.white : const Color(0xff6D2D83),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    '150 DWK',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      color:
                          isSelected ? Colors.white : const Color(0xff6D2D83),
                    ),
                  ),
                ),
              ],
            )));
  }
}
