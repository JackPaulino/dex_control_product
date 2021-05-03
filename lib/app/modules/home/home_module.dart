import 'package:dex_control_product/app//modules/home/product/product_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../home/home_store.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [Bind.lazySingleton((i) => ProductStore()),
    Bind.lazySingleton((i) => HomeStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => HomePage(
            user: args.data[0],
            products: args.data[1],
            totalPage: args.data[2]),
        transition: TransitionType.rightToLeft),
  ];
}