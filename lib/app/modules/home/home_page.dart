import 'package:dex_control_product/app/shared/models/user_model.dart';
import 'package:dex_control_product/app/shared/useful/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  final UserModel user;
  final List<UserModel> products;
  const HomePage(
      {Key? key,
      this.title = "Home",
      required this.user,
      required this.products})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore store = Modular.get();
  @override
  void initState() {
    super.initState();
    store.user = widget.user;
    store.listProdut.addAll(widget.products);
    store.getProduts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black12,
            title: Text('Bem vindo ${store.user.name}'),
            floating: true,
            snap: true,
            actions: [
              PopupMenuButton<String>(
                  icon: Icon(MdiIcons.filterMenuOutline),
                  elevation: 10,
                  itemBuilder: (context) => <PopupMenuEntry<String>>[
                        PopupMenuItem(child: Text('Data'), value: 'dt'),
                        PopupMenuItem(child: Text('Preço'), value: 'dt'),
                        PopupMenuItem(child: Text('A-Z'), value: 'dt')
                      ],
                  onSelected: (result) {}),
            ],
          ),
          SliverGrid(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                if (index ==
                        store.listProdut.length -
                            store.pagePrudut['pass_page'] &&
                    store.pagePrudut["has_more"]) {
                  store.getProduts();
                }
                if (index == store.listProdut.length &&
                    store.pagePrudut["has_more"]) {
                  if (store.pagePrudut["error"]) {
                    return Center(
                      child: InkWell(
                        onTap: () {
                          setState(
                            () {
                              store.pagePrudut['loading'] = true;
                              store.pagePrudut['error'] = false;
                              store.getProduts();
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                              "Erro ao carregar produtos em oferta. Toque aqui para tentar novamente!"),
                        ),
                      ),
                    );
                  } else {
                    return Center(
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    AppColors.primary))));
                  }
                }
                return Text(
                    '${store.listProdut[index].name} - $index - ${store.listProdut[index].id}');
              }),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: .58,
              ))
        ],
      ),
      /* floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ), */
    );
  }
}
