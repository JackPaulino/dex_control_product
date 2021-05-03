import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';
import 'modules/login/login_page.dart';
import 'modules/login/login_store.dart';
import 'shared/splash/splash_page.dart';
import 'shared/splash/splash_store.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => LoginStore()),
    Bind((i) => SplashStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => SplashPage()),
    ModuleRoute('/home',
        module: HomeModule(), transition: TransitionType.fadeIn),
    ChildRoute('/login', child: (_, args) => LoginPage()),
  ];
}
