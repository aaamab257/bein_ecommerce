class UserModel {
  String? firstName;

  String? lastName;

  String? address;

  Email? email;

  Phone? phone;

  UserModel(
      {required this.firstName, required this.lastName, required this.address , required this.phone , required this.email});
}

class Email {
  bool? verified;
  String? address;

  Email({required this.verified, required this.address});
}

class Phone {
  String? phoneNumber;

  Phone({required this.phoneNumber});
}
