import 'dart:convert';

import 'package:dex_control_product/app/shared/models/product_model.dart';
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
  ObservableList<ProductModel> listProdut = <ProductModel>[].asObservable();

  Map<String, dynamic> pageProdut = {
    'limit': 22,
    'offset': 22,
    'error': false,
    'total_page': 0,
    'pass_page': 6,
    'loading': false,
    'has_more': true,
  };

  @observable
  String filter = '1 = 1';

  @observable
  Map<bool, String> alfa = {true: 'A - Z', false: 'Z - A'};

  Future<void> countProdut() async {
    Database? dbDex = await helper.db;
    pageProdut['total_page'] = Sqflite.firstIntValue(await dbDex!
        .rawQuery('SELECT COUNT(*) FROM ${helper.productModel} WHERE $filter'));
  }

  @action
  Future<void> getProduts() async {
    print('getProduts');
    try {
      countProdut();
      Database? dbDex = await helper.db;
      List<Map> products = await dbDex!.rawQuery(
          'SELECT ${helper.productModel}.* FROM ${helper.productModel} WHERE $filter LIMIT ${pageProdut['limit']} OFFSET ${pageProdut['offset']} ');

      if (products.length > 0) {
        for (var item in products) {
          Map<String, dynamic> map = json.decode(json.encode(item));
          listProdut.add(new ProductModel.fromJson(map));
        }
        pageProdut['offset'] += pageProdut['limit'];
        pageProdut['has_more'] =
            products.length == pageProdut['limit'] ? true : false;
        pageProdut['error'] = false;
      } else
        pageProdut['has_more'] = false;
    } catch (e) {
      pageProdut['error'] = true;
    }
  }

  @action
  Future<void> aplicFilter() async {
    print('getProduts');
    try {
      countProdut();
      Database? dbDex = await helper.db;
      List<Map> products = await dbDex!.rawQuery(
          'SELECT ${helper.productModel}.* FROM ${helper.productModel} WHERE $filter LIMIT ${pageProdut['limit']} OFFSET ${pageProdut['offset']} ');

      if (products.length > 0) {
        for (var item in products) {
          Map<String, dynamic> map = json.decode(json.encode(item));
          listProdut.add(new ProductModel.fromJson(map));
        }
        pageProdut['offset'] += pageProdut['limit'];
        pageProdut['has_more'] =
            products.length == pageProdut['limit'] ? true : false;
        pageProdut['error'] = false;
      } else
        pageProdut['has_more'] = false;
    } catch (e) {
      pageProdut['error'] = true;
    }
  }
}
