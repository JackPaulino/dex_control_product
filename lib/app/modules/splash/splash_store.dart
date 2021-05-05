import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dex_control_product/app/shared/models/login.dart';
import 'package:dex_control_product/app/shared/models/product_model.dart';
import 'package:dex_control_product/app/shared/models/user_model.dart';
import 'package:dex_control_product/app/shared/useful/crypto_password.dart';
import 'package:dex_control_product/app/shared/useful/helper.dart';
import 'package:dex_control_product/app/shared/useful/text_style.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:sqflite/sqflite.dart';

part 'splash_store.g.dart';

class SplashStore = _SplashStoreBase with _$SplashStore;

abstract class _SplashStoreBase with Store {
  @observable
  DataBaseHelper helper = DataBaseHelper();

  @observable
  UserModel user = UserModel();

  @observable
  String status = '';

  @observable
  int totalPage = 0;

  List<ProductModel> products = [];

  @action
  Future<void> checkConnection() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.mobile &&
          connectivityResult != ConnectivityResult.wifi) {
        status = "Acesso Offline";
      }
      Future.delayed(Duration(seconds: 4)).then((value) => autoLogin());
    } catch (e) {
      print(e);
      status = 'Ocorreu um Erro, Tente Novamente.';
    }
  }

  @action
  Future<void> autoLogin() async {
    Database? dbDex = await helper.db;

    /* List listUser = await dbDex!.rawQuery("SELECT * FROM ${helper.userModel}");

    for (Map m in listUser) {
      print(m);
    }

    List listLogin = await dbDex.rawQuery("SELECT * FROM ${helper.loginModel}");

    for (Map m in listLogin) {
      print(m);
    } */

    List<Map> userAutoLogin = await dbDex!.rawQuery(
        'SELECT ${helper.loginModel}.*,  ${helper.userModel}.* ' +
            'FROM ${helper.loginModel} ' +
            'INNER JOIN ${helper.userModel} ON ' +
            '${helper.loginModel}.${helper.userLoginId} = ' +
            '${helper.userModel}.${helper.idUser}');
    if (userAutoLogin.length > 0) {
      user = UserModel(
          id: userAutoLogin[0]['${helper.idUser}'],
          name: userAutoLogin[0]['${helper.nameUser}'],
          password: userAutoLogin[0]['${helper.password}']);
      initListProduts();
    } else {
      Modular.to.pushReplacementNamed('/login');
    }
  }

  @action //Inserir userModel
  Future<void> insertUseModel() async {
    try {
      Database? dbDex = await helper.db;
      user =
          UserModel(name: 'Jackson', password: convertPassaword('program2021'));
      user.id = await dbDex!.insert(helper.userModel, user.toJson());
      user = UserModel(name: 'Dex', password: convertPassaword('floripa2021'));
      user.id = await dbDex.insert(helper.userModel, user.toJson());
      user = UserModel(
          name: 'flutter', password: convertPassaword('flutter2.3.0-1.0'));
      user.id = await dbDex.insert(helper.userModel, user.toJson());
    } catch (e) {
      print(e);
    }
  }

  @action //Inserir LoginModel
  Future<void> insertLogAcess({int? user}) async {
    try {
      Database? dbDex = await helper.db;
      LoginModel login = LoginModel(
          initLogin: Appformat.dateHifen.format(DateTime.now()), userId: user);
      var result = await dbDex!.insert(helper.loginModel, login.toJson());
      print(result);
    } catch (e) {
      print(e);
    }
  }

  Future<int?> countProdut() async {
    Database? dbDex = await helper.db;
    totalPage += Sqflite.firstIntValue(
        await dbDex!.rawQuery('SELECT COUNT(*) FROM ${helper.productModel}'))!;
  }

  @action
  Future<void> initListProduts() async {
    print('getProduts');
    try {
      Database? dbDex = await helper.db;
      List<Map> userAutoLogin = await dbDex!.rawQuery(
          'SELECT  ${helper.productModel}.* FROM ${helper.productModel} LIMIT 22 OFFSET 0');
      if (userAutoLogin.length > 0) {
        for (var item in userAutoLogin) {
          Map<String, dynamic> map = json.decode(json.encode(item));
          products.add(new ProductModel.fromJson(map));
        }
      }
      countProdut().then((value) => Modular.to.pushReplacementNamed('/home',
          arguments: [user, products, totalPage]));
    } catch (e) {
      print(e);
    }
  }

  @action
  Future<void> insertProduts() async {
    print('insertProduts');
    try {
      Database? dbDex = await helper.db;
      for (var i = 0; i < 100; i++) {
        ProductModel prod = ProductModel(
            name: 'Arroz$i', img: '$i', preco: (3.25 + i), quant: (16.0 + i));
        await dbDex!.insert(helper.productModel, prod.toJson());
      }
    } catch (e) {
      print(e);
    }
  }
}