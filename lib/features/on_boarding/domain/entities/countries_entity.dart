import 'package:bein_ecommerce/features/on_boarding/data/models/country.dart';

class CountryEntity{
  final String name ;
  final String id ;
  final String currency ;
  String internationalCallingCode;
  final String code ;

  CountryEntity({required this.name ,required this.id , required this.currency , required this.internationalCallingCode , required this.code});


}