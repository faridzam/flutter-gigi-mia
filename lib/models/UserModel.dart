class UserModel{
  late int id;
  String username = '';
  String phone = '';
  String password = '';

  UserModel(this.username, this.phone, this.password);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'username': username,
      'phone': phone,
      'password': password,
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map){
    id = map['id'];
    username = map['username'];
    phone = map['phone'];
    password = map['password'];
  }

}