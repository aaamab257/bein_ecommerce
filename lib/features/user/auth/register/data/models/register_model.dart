class RegisterModel {
  String? name;
  String? email;
  String? phone;
  bool? is_admin, is_user, is_vendor;
  String? password, password2;

  RegisterModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.is_admin,
    required this.is_user,
    required this.is_vendor,
    required this.password,
    required this.password2,
  });
}
