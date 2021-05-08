import 'package:dex_control_product/app/shared/useful/text_style.dart';

class LoginModel {
  late int id;
  late DateTime initLogin;
  late int userId;

  LoginModel({required this.id, required this.initLogin, required this.userId});

  LoginModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    initLogin = Appformat.dateHifen.parse(json['init_login']);
    userId = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['init_login'] = Appformat.dateHifen.format(this.initLogin);
    data['user_id'] = this.userId;

    return data;
  }
}
