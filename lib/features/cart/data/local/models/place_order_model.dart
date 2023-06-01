class PlaceOrderRequest {
  String? firstName;

  String? lastName;

  String? phone;

  String? email;

  String? address;

  String? nationalId;
  String? payType;

  PlaceOrderRequest(
      {required this.payType,
      required this.phone,
      required this.email,
      required this.address,
      required this.firstName,
      required this.lastName,
      required this.nationalId});
}
