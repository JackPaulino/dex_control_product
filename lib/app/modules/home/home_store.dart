import 'package:dex_control_product/app/shared/models/product_model.dart';
import 'package:dex_control_product/app/shared/models/user_model.dart';
import 'package:dex_control_product/app/shared/useful/helper.dart';
import 'package:dex_control_product/app/shared/useful/text_style.dart';
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
    'pass_page': 6,
    'loading': false,
    'has_more': true,
  };

  @observable
  String filter = '';

  @observable
  String detailFilter = '';

  @observable
  Map<bool, String> alfa = {true: 'A - Z', false: 'Z - A'};

  Map<bool, String> ascDesc = {true: 'DESC', false: 'ASC'};

  @action
  Future<void> getProduts({bool refresh = false}) async {
    print('getProduts');
    pageProdut['error'] = false;
    try {
      if (refresh) {
        pageProdut['limit'] = 22;
        pageProdut['offset'] = 0;
        pageProdut['has_more'] = true;
        listProdut = <ProductModel>[].asObservable();
      }
      Database? dbDex = await helper.db;
      List<Map> products = await dbDex!.rawQuery(
          'SELECT * FROM ${helper.productModel} $filter LIMIT ${pageProdut['limit']} OFFSET ${pageProdut['offset']}');
      if (products.length > 0) {
        for (var item in products) {
          ProductModel prod = new ProductModel.fromJson(item);
          if (listProdut.where((p) => p.id == prod.id).length == 0) {
            listProdut.add(prod);
          }
        }
      } else
        pageProdut['has_more'] = false;
    } catch (e) {
      pageProdut['error'] = true;
    }
  }

  @action
  void aplyFilter({dynamic value, required int type}) {
    switch (type) {
      case 0:
        filter =
            'WHERE ${helper.dateModify} = \'${Appformat.dateHifen.format(value)}\'';
        detailFilter = 'Data: ${Appformat.date.format(value)}';
        break;
      case 1:
        filter = 'WHERE ${helper.price} = ${Appformat.quantity.parse(value)}';
        detailFilter = 'Preço: $value';
        break;
      case 2:
        filter = 'ORDER BY LOWER(${helper.nameProduct}) ${ascDesc[value]}';
        detailFilter = 'ORDER: ${alfa[value]}';
        break;
      default:
        filter = '';
        detailFilter = '';
    }
    getProduts(refresh: true);
  }

  @action
  Future<void> deleteProduct(ProductModel prod) async {
    Database? dbDex = await helper.db;
    await dbDex!.delete(helper.productModel,
        where: "${helper.idProduct} =?", whereArgs: [prod.id]);
    getProduts(refresh: true);
  }
}
