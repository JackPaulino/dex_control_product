import 'package:mobx/mobx.dart';

part 'product_store.g.dart';

class ProductStore = _ProductStoreBase with _$ProductStore;

abstract class _ProductStoreBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
