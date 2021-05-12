import 'dart:convert';
import 'dart:io';

import 'package:dex_control_product/app/modules/home/home_store.dart';
import 'package:dex_control_product/app/shared/models/product_model.dart';
import 'package:dex_control_product/app/shared/useful/helper.dart';
import 'package:dex_control_product/app/shared/useful/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:sqflite/sqflite.dart';
part 'product_store.g.dart';

class ProductStore = _ProductStoreBase with _$ProductStore;

abstract class _ProductStoreBase with Store {
  @observable
  DataBaseHelper helper = DataBaseHelper();

  @observable
  bool loading = false;

  @observable
  bool edit = false;

  @observable
  ImagePicker picker = ImagePicker();

  @observable
  ProductModel product = ProductModel(
      codigo: 0,
      name: '',
      dateModify: Appformat.dateHifen.format(DateTime.now()));

  @observable
  HomeStore homeStore = Modular.get<HomeStore>();

  @observable
  TextEditingController codigoController = new TextEditingController();

  @observable
  TextEditingController nameController = new TextEditingController();

  @observable
  TextEditingController priceController = new TextEditingController();

  @observable
  TextEditingController stockController = new TextEditingController();

  @observable
  GlobalKey<FormState> productForm = GlobalKey<FormState>();

  @action
  void setEdit() => edit = !edit;

  @action
  void preencherProduct() {
    nameController.text = product.name;
    codigoController.text = product.codigo.toString();
    priceController.text = Appformat.quantity.format(product.price);
    stockController.text = Appformat.quantity.format(product.stock);
  }

  @action
  String? validCodigo(String texto) {
    if (texto.isEmpty) {
      return "Digite o codigo do produto";
    }
    return null;
  }

  @action
  String? validName(String texto) {
    if (texto.isEmpty) {
      return "Digite o nome do Produto";
    }
    return null;
  }

  @action
  String? validPrice(String texto) {
    if (texto.isEmpty) {
      return "Digite o preço do Produto";
    }
    return null;
  }

  @action
  String? validStock(String texto) {
    if (texto.isEmpty) {
      return "Digite a quantidade de estoque";
    }
    return null;
  }

  @action
  bool habiliteButton() {
    return (codigoController.text != '' && nameController.text != '')
        ? true
        : false;
  }

  @action
  Future<void> setImage() async {
    await picker
        .getImage(source: ImageSource.camera, maxHeight: 400, maxWidth: 400)
        .then((imgFile) async {
      if (imgFile != null) {
        final bytes = File(imgFile.path).readAsBytesSync();
        product = product.copyWith(image: base64Encode(bytes));
        Database? dbDex = await helper.db;
        await dbDex!.update(helper.productModel, product.toJson(),
            where: "${helper.idProduct}=?", whereArgs: [product.id]);
        homeStore.getProduts(refresh: true);
      } else {
        print('No image selected.');
      }
    });
  }

  @action
  Future<void> insertProduct() async {
    try {
      product = product.copyWith(
          codigo: int.parse(codigoController.text),
          name: nameController.text == '' ? null : nameController.text,
          price: Appformat.quantity.parse(priceController.text).toDouble(),
          stock: Appformat.quantity.parse(stockController.text).toDouble(),
          dateModify: Appformat.dateHifen.format(DateTime.now()));
      Database? dbDex = await helper.db;
      await dbDex!.insert(helper.productModel, product.toJson());
      homeStore.getProduts(refresh: true);
      setEdit();
    } catch (e) {
      print(e);
    }
  }

  @action
  Future<void> updateProduct({bool upProd = true}) async {
    try {
      if (upProd) {
        product = product.copyWith(
            codigo: int.parse(codigoController.text),
            name: nameController.text == '' ? null : nameController.text,
            price: double.parse(
                priceController.text.replaceAll('.', '').replaceAll(',', '.')),
            stock: double.parse(
                stockController.text.replaceAll('.', '').replaceAll(',', '.')),
            dateModify: Appformat.dateHifen.format(DateTime.now()));
      }
      Database? dbDex = await helper.db;
      await dbDex!.update(helper.productModel, product.toJson(),
          where: "${helper.idProduct}=?", whereArgs: [product.id]);
      homeStore.getProduts(refresh: true);
      setEdit();
    } catch (e) {
      print(e);
    }
  }
}
