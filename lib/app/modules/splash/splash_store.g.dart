// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SplashStore on _SplashStoreBase, Store {
  final _$helperAtom = Atom(name: '_SplashStoreBase.helper');

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

  final _$userAtom = Atom(name: '_SplashStoreBase.user');

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

  final _$statusAtom = Atom(name: '_SplashStoreBase.status');

  @override
  String get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(String value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$checkConnectionAsyncAction =
      AsyncAction('_SplashStoreBase.checkConnection');

  @override
  Future<void> checkConnection() {
    return _$checkConnectionAsyncAction.run(() => super.checkConnection());
  }

  final _$autoLoginAsyncAction = AsyncAction('_SplashStoreBase.autoLogin');

  @override
  Future<void> autoLogin() {
    return _$autoLoginAsyncAction.run(() => super.autoLogin());
  }

  final _$insertUseModelAsyncAction =
      AsyncAction('_SplashStoreBase.insertUseModel');

  @override
  Future<void> insertUseModel() {
    return _$insertUseModelAsyncAction.run(() => super.insertUseModel());
  }

  final _$insertLogAcessAsyncAction =
      AsyncAction('_SplashStoreBase.insertLogAcess');

  @override
  Future<void> insertLogAcess({int user = 0}) {
    return _$insertLogAcessAsyncAction
        .run(() => super.insertLogAcess(user: user));
  }

  final _$initListProdutsAsyncAction =
      AsyncAction('_SplashStoreBase.initListProduts');

  @override
  Future<void> initListProduts() {
    return _$initListProdutsAsyncAction.run(() => super.initListProduts());
  }

  @override
  String toString() {
    return '''
helper: ${helper},
user: ${user},
status: ${status}
    ''';
  }
}
