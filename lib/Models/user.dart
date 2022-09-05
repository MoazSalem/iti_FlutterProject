class UserModel {
  String name = "";
  String email = "";
  String phone = "";

  UserModel({required this.name, required this.email, required this.phone});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
