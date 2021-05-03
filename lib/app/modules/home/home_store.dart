import 'dart:convert';

import 'package:dex_control_product/app/shared/models/user_model.dart';
import 'package:dex_control_product/app/shared/useful/helper.dart';
import 'package:mobx/mobx.dart';
import 'package:sqflite/sqflite.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  @observable
  DataBaseHelper helper = DataBaseHelper();

  @observable
  UserModel user = UserModel();

  @observable
  ObservableList<UserModel> listProdut = <UserModel>[].asObservable();

  Map<String, dynamic> pagePrudut = {
    'limit': 18,
    'offset': 10,
    'error': false,
    'pass_page': 6,
    'loading': false,
    'has_more': true,
  };

  @action
  Future<void> getProduts() async {
    print('getProduts');
    Database? dbDex = await helper.db;
    List<Map> userAutoLogin = await dbDex!.rawQuery(
        'SELECT  ${helper.userModel}.* FROM ${helper.userModel} LIMIT ${pagePrudut['limit']} OFFSET ${pagePrudut['offset']} ');
    if (userAutoLogin.length > 0) {
      for (var item in userAutoLogin) {
        Map<String, dynamic> map = json.decode(json.encode(item));
        listProdut.add(new UserModel.fromJson(map));
      }
    } else {}
  }
}
