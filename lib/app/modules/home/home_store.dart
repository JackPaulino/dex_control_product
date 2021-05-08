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
    'backut_limit': 22,
    'offset': 22,
    'bakut_offset': 22,
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

  @action
  Future<void> getProduts({bool refresh = false}) async {
    print('getProduts');
    try {
      if (refresh) {
        pageProdut['backut_limit'] = pageProdut['limit'];
        pageProdut['bakut_offset'] = pageProdut['offset'];
        pageProdut['limit'] = listProdut.length;
        pageProdut['offset'] = '0';
        listProdut = <ProductModel>[].asObservable();
      }
      Database? dbDex = await helper.db;
      List<Map> products = await dbDex!.rawQuery(
          'SELECT * FROM ${helper.productModel} WHERE $filter LIMIT ${pageProdut['limit']} OFFSET ${pageProdut['offset']} ');

      if (products.length > 0) {
        for (var item in products) {
          Map<String, dynamic> map = json.decode(json.encode(item));
          ProductModel prod = new ProductModel.fromJson(map);
          if (listProdut.where((p) => p.id == prod.id).length == 0) {
            listProdut.add(prod);
          }
        }
        if (refresh) {
          pageProdut['limit'] = pageProdut['backut_limit'];
          pageProdut['offset'] = pageProdut['bakut_offset'];
        } else {
          pageProdut['offset'] += pageProdut['limit'];
          pageProdut['has_more'] =
              products.length == pageProdut['limit'] ? true : false;
          pageProdut['total_page'] = products.length;
          pageProdut['error'] = false;
        }
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

  Future<void> deleteProduct(ProductModel prod) async {
    Database? dbDex = await helper.db;
    await dbDex!.delete(helper.productModel,
        where: "${helper.idProduct} =?", whereArgs: [prod.id]);
    getProduts(refresh: true);
  }
}
