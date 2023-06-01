import 'package:bein_ecommerce/features/on_boarding/domain/entities/countries_entity.dart';

class CountryModel {
  String? id;
  String? name;
  String? currency;
  int? currencyDecimalPoint;
  String? internationalCallingCode;
  String? status;
  String? createdDate;

  CountryModel(
      {this.id,
        this.name,
        this.currency,
        this.currencyDecimalPoint,
        this.internationalCallingCode,
        this.status,
        this.createdDate});

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    currency = json['currency'];
    currencyDecimalPoint = json['currencyDecimalPoint'];
    internationalCallingCode = json['internationalCallingCode'];
    status = json['status'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['currency'] = currency;
    data['currencyDecimalPoint'] = currencyDecimalPoint;
    data['internationalCallingCode'] = internationalCallingCode;
    data['status'] = status;
    data['createdDate'] = createdDate;
    return data;
  }

  CountryEntity toEntity(){
    return CountryEntity(name: name ?? "EGYPT", id: id ?? "1" , currency: currency ?? "LE");
}


}