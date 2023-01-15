class UserModel{
  late int id;
  String username = '';
  String phone = '';
  String email = '';
  String password = '';

  UserModel(this.username, this.phone, this.email, this.password);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'username': username,
      'phone': phone,
      'email': email,
      'password': password,
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map){
    id = map['id'];
    username = map['username'];
    phone = map['phone'];
    email = map['email'];
    password = map['password'];
  }

}