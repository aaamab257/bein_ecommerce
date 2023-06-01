import 'package:bein_ecommerce/features/on_boarding/data/models/country.dart';
import 'package:bein_ecommerce/features/on_boarding/domain/entities/countries_entity.dart';

extension CounttryEntityToModel on CountryEntity {

  toModel(){
    return CountryModel(
      createdDate: "",
      currency: "",
      currencyDecimalPoint: null,
      id: id,
      internationalCallingCode: null,
      name: name,
    );
  }

}