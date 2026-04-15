class Usermodel {

  String? name;
  String? email;
  String? password;
  String? phoneNumber;


  Usermodel({
    this.name,
    this.email,
    this.password,
    this.phoneNumber,
  });
  factory Usermodel.fromJson(Map<String, dynamic> json) {
    return Usermodel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
    };
  }
}