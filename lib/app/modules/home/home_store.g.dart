// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on HomeStoreBase, Store {
  final _$helperAtom = Atom(name: 'HomeStoreBase.helper');

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

  final _$userAtom = Atom(name: 'HomeStoreBase.user');

  @override
  UserModel get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$listProdutAtom = Atom(name: 'HomeStoreBase.listProdut');

  @override
  ObservableList<ProductModel> get listProdut {
    _$listProdutAtom.reportRead();
    return super.listProdut;
  }

  @override
  set listProdut(ObservableList<ProductModel> value) {
    _$listProdutAtom.reportWrite(value, super.listProdut, () {
      super.listProdut = value;
    });
  }

  final _$filterAtom = Atom(name: 'HomeStoreBase.filter');

  @override
  String get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(String value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  final _$alfaAtom = Atom(name: 'HomeStoreBase.alfa');

  @override
  Map<bool, String> get alfa {
    _$alfaAtom.reportRead();
    return super.alfa;
  }

  @override
  set alfa(Map<bool, String> value) {
    _$alfaAtom.reportWrite(value, super.alfa, () {
      super.alfa = value;
    });
  }

  final _$getProdutsAsyncAction = AsyncAction('HomeStoreBase.getProduts');

  @override
  Future<void> getProduts() {
    return _$getProdutsAsyncAction.run(() => super.getProduts());
  }

  final _$aplicFilterAsyncAction = AsyncAction('HomeStoreBase.aplicFilter');

  @override
  Future<void> aplicFilter() {
    return _$aplicFilterAsyncAction.run(() => super.aplicFilter());
  }

  @override
  String toString() {
    return '''
helper: ${helper},
user: ${user},
listProdut: ${listProdut},
filter: ${filter},
alfa: ${alfa}
    ''';
  }
}
