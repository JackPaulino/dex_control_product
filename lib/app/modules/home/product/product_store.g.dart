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

  final _$setImageAsyncAction = AsyncAction('_ProductStoreBase.setImage');

  @override
  Future<void> setImage() {
    return _$setImageAsyncAction.run(() => super.setImage());
  }

  final _$updateCardAsyncAction = AsyncAction('_ProductStoreBase.updateCard');

  @override
  Future<void> updateCard(ProductModel prod) {
    return _$updateCardAsyncAction.run(() => super.updateCard(prod));
  }

  @override
  String toString() {
    return '''
helper: ${helper},
loading: ${loading},
picker: ${picker},
product: ${product},
homeStore: ${homeStore}
    ''';
  }
}
