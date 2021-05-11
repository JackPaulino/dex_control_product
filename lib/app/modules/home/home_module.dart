import 'package:dex_control_product/app/modules/home/product/product_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';
import 'home_store.dart';
import 'product/product_store.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
    Bind.lazySingleton((i) => ProductStore())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) =>
            HomePage(user: args.data[0], products: args.data[1]),
        transition: TransitionType.rightToLeft),
    ChildRoute('/product',
        child: (_, args) =>
            ProductPage(product: args.data[0], newProduct: args.data[1]),
        transition: TransitionType.rightToLeft),
  ];
}
