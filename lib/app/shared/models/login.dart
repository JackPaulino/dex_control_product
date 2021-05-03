class LoginModel {
  int? id;
  String? initLogin;
  int? userId;

  LoginModel({this.id, this.initLogin, this.userId});

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    initLogin = json['init_login'];
    userId = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['init_login'] = this.initLogin;
    data['user_id'] = this.userId;

    return data;
  }
}
