// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductStore on _ProductStoreBase, Store {
  final _$helperAtom = Atom(name: '_ProductStoreBase.helper');

  @override
  DataBaseHelper get helper {
    _$helperAtom.reportRead();
    return super.helper;
  }

  @override
  set helper(DataBaseHelper value) {
    _$helperAtom.reportWrite(value, super.helper, () {
      super.helper = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ProductStoreBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$editAtom = Atom(name: '_ProductStoreBase.edit');

  @override
  bool get edit {
    _$editAtom.reportRead();
    return super.edit;
  }

  @override
  set edit(bool value) {
    _$editAtom.reportWrite(value, super.edit, () {
      super.edit = value;
    });
  }

  final _$pickerAtom = Atom(name: '_ProductStoreBase.picker');

  @override
  ImagePicker get picker {
    _$pickerAtom.reportRead();
    return super.picker;
  }

  @override
  set picker(ImagePicker value) {
    _$pickerAtom.reportWrite(value, super.picker, () {
      super.picker = value;
    });
  }

  final _$productAtom = Atom(name: '_ProductStoreBase.product');

  @override
  ProductModel get product {
    _$productAtom.reportRead();
    return super.product;
  }

  @override
  set product(ProductModel value) {
    _$productAtom.reportWrite(value, super.product, () {
      super.product = value;
    });
  }

  final _$homeStoreAtom = Atom(name: '_ProductStoreBase.homeStore');

  @override
  HomeStore get homeStore {
    _$homeStoreAtom.reportRead();
    return super.homeStore;
  }

  @override
  set homeStore(HomeStore value) {
    _$homeStoreAtom.reportWrite(value, super.homeStore, () {
      super.homeStore = value;
    });
  }

  final _$nameControllerAtom = Atom(name: '_ProductStoreBase.nameController');

  @override
  TextEditingController get nameController {
    _$nameControllerAtom.reportRead();
    return super.nameController;
  }

  @override
  set nameController(TextEditingController value) {
    _$nameControllerAtom.reportWrite(value, super.nameController, () {
      super.nameController = value;
    });
  }

  final _$priceControllerAtom = Atom(name: '_ProductStoreBase.priceController');

  @override
  TextEditingController get priceController {
    _$priceControllerAtom.reportRead();
    return super.priceController;
  }

  @override
  set priceController(TextEditingController value) {
    _$priceControllerAtom.reportWrite(value, super.priceController, () {
      super.priceController = value;
    });
  }

  final _$stockControllerAtom = Atom(name: '_ProductStoreBase.stockController');

  @override
  TextEditingController get stockController {
    _$stockControllerAtom.reportRead();
    return super.stockController;
  }

  @override
  set stockController(TextEditingController value) {
    _$stockControllerAtom.reportWrite(value, super.stockController, () {
      super.stockController = value;
    });
  }

  final _$productFormAtom = Atom(name: '_ProductStoreBase.productForm');

  @override
  GlobalKey<FormState> get productForm {
    _$productFormAtom.reportRead();
    return super.productForm;
  }

  @override
  set productForm(GlobalKey<FormState> value) {
    _$productFormAtom.reportWrite(value, super.productForm, () {
      super.productForm = value;
    });
  }

  final _$setImageAsyncAction = AsyncAction('_ProductStoreBase.setImage');

  @override
  Future<void> setImage() {
    return _$setImageAsyncAction.run(() => super.setImage());
  }

  final _$insertProductAsyncAction =
      AsyncAction('_ProductStoreBase.insertProduct');

  @override
  Future<void> insertProduct() {
    return _$insertProductAsyncAction.run(() => super.insertProduct());
  }

  final _$updateProductAsyncAction =
      AsyncAction('_ProductStoreBase.updateProduct');

  @override
  Future<void> updateProduct({bool upProd = true}) {
    return _$updateProductAsyncAction
        .run(() => super.updateProduct(upProd: upProd));
  }

  final _$_ProductStoreBaseActionController =
      ActionController(name: '_ProductStoreBase');

  @override
  void setEdit() {
    final _$actionInfo = _$_ProductStoreBaseActionController.startAction(
        name: '_ProductStoreBase.setEdit');
    try {
      return super.setEdit();
    } finally {
      _$_ProductStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? validName(String texto) {
    final _$actionInfo = _$_ProductStoreBaseActionController.startAction(
        name: '_ProductStoreBase.validName');
    try {
      return super.validName(texto);
    } finally {
      _$_ProductStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? validPrice(String texto) {
    final _$actionInfo = _$_ProductStoreBaseActionController.startAction(
        name: '_ProductStoreBase.validPrice');
    try {
      return super.validPrice(texto);
    } finally {
      _$_ProductStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? validStock(String texto) {
    final _$actionInfo = _$_ProductStoreBaseActionController.startAction(
        name: '_ProductStoreBase.validStock');
    try {
      return super.validStock(texto);
    } finally {
      _$_ProductStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
helper: ${helper},
loading: ${loading},
edit: ${edit},
picker: ${picker},
product: ${product},
homeStore: ${homeStore},
nameController: ${nameController},
priceController: ${priceController},
stockController: ${stockController},
productForm: ${productForm}
    ''';
  }
}
