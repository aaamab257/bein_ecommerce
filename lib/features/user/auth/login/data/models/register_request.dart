class RegisterRequest {
  /*
  {
    "phoneNumber":"+201016348221",
    "cartId":"",
    "email":"ahmed@gmail.com",
    "countryId":"642bcfdb4a786d1acc10978d"
}*/
  String? phone;

  String? email;

  String? cartId;

  String? countryId;

  RegisterRequest(
      {required this.phone,
      required this.email,
      required this.cartId,
      required this.countryId});
}
