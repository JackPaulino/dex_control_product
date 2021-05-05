import 'dart:convert';

import 'package:dex_control_product/app/shared/models/product_model.dart';
import 'package:dex_control_product/app/shared/models/user_model.dart';
import 'package:dex_control_product/app/shared/useful/crypto_password.dart';
import 'package:dex_control_product/app/shared/useful/helper.dart';
import 'package:dex_control_product/app/shared/useful/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:sqflite/sqflite.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  @observable
  DataBaseHelper helper = DataBaseHelper();

  @observable
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  @observable
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @observable
  TextEditingController ctrlLogin = new TextEditingController();

  @observable
  TextEditingController ctrlSenha = new TextEditingController();

  @observable
  UserModel user = UserModel();

  @observable
  bool loading = false;

  @observable
  String status = '';

  @observable
  bool visibilityPassword = true;

  @action
  void setvisibility() => visibilityPassword = !visibilityPassword;

  List<ProductModel> products = [];

  @action
  String? validaLogin(String texto) {
    print(texto.isEmpty);
    if (texto.isEmpty) {
      return "Digite o Login";
    }
    return null;
  }

  @action
  String? validaSenha(String texto) {
    if (texto.isEmpty || ctrlSenha.text.length < 5) {
      return "Digite a Senha com no minimo 6 digitos";
    }
    return null;
  }

  void login() async {
    loading = true;
    // ignore: unnecessary_null_comparison
    if (formKey.currentState!.validate != null) {
      try {
        Database? dbDex = await helper.db;
        List<Map> login = await dbDex!.rawQuery('SELECT ${helper.userModel}.* ' +
            'FROM ${helper.userModel} WHERE ' +
            '${helper.nameUser} = \'${ctrlLogin.text.replaceAll(RegExp(r' '), '')}\' ' +
            'AND ${helper.password} = \'${convertPassaword(ctrlSenha.text.replaceAll(RegExp(r' '), ''))}\'');
        if (login.length > 0) {
          user = UserModel(
              id: login[0]['${helper.idUser}'],
              name: login[0]['${helper.nameUser}'],
              password: login[0]['${helper.password}']);
          insertLogAcess(us: user.id);
        } else {
          loading = false;
          status = 'Usuário e/ou senha incorreto(s). Tente Novamente';
        }
      } catch (e) {
        loading = false;
        status = 'Usuário e/ou senha incorreto(s). Tente Novamente';
        print(e);
      }
    } else {
      loading = false;
      status = 'Verirfique os Dados!';
    }
  }

  @action //Inserir userModel
  Future<void> insertUseModel() async {
    try {
      Database? dbDex = await helper.db;
      user = UserModel(
          name: '${ctrlLogin.text}',
          password: convertPassaword('${ctrlSenha.text}'));
      user.id = await dbDex!.insert(helper.userModel, user.toJson());
      insertLogAcess(us: user.id);
    } catch (e) {
      loading = false;
      print(e);
    }
  }

  @action //Inserir LoginModel
  Future<void> insertLogAcess({int? us}) async {
    try {
      Database? dbDex = await helper.db;
      var login = {
        '${helper.initLogin}': '${Appformat.datehour.format(DateTime.now())}',
        '${helper.userLoginId}': us
      };
      await dbDex!.insert(helper.loginModel, login);
      initListProduts();
    } catch (e) {
      loading = false;
      print(e);
    }
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
      Modular.to.pushReplacementNamed('/home', arguments: [user, products]);
    } catch (e) {
      print(e);
    }
  }
}
