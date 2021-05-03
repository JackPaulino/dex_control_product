import 'package:dex_control_product/app/modules/home/home_store.dart';
import 'package:dex_control_product/app/shared/models/product_model.dart';
import 'package:dex_control_product/app/shared/models/user_model.dart';
import 'package:dex_control_product/app/shared/useful/app_colors.dart';
import 'package:dex_control_product/app/shared/useful/custom_decimal.dart';
import 'package:dex_control_product/app/shared/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget {
  final String title;
  final int totalPage;
  final UserModel user;
  final List<ProductModel> products;
  const HomePage(
      {Key? key,
      this.title = "Home",
      required this.user,
      required this.products,
      required this.totalPage})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  TextEditingController qtdController = new TextEditingController();
  bool ordem = true;

  @override
  void initState() {
    super.initState();
    controller.user = widget.user;
    controller.pageProdut['total_page'] = widget.totalPage;
    controller.listProdut.addAll(widget.products);
  }

  Future<void> _showDatePicker(context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                    primary:
                        AppColors.greenBlueGrayola, // header background color
                    onPrimary: Colors.white, // header text color
                    onSurface: Colors.black), // body text color
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        primary:
                            AppColors.greenBlueGrayola))), // button text color
            child: child!);
      },
    );
    if (picked != null) {
      /* userController.dtNasc = Appformat.dateHifen.format(picked);
    userController.dataNascimentoController.text =
        Appformat.date.format(picked); */
    }
  }

  _textfied() {
    return Row(
      children: [
        Expanded(
            child: TextField(
                controller: qtdController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Colors.black),
                showCursor: false,
                decoration: new InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide:
                            BorderSide(color: AppColors.primary, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide:
                            BorderSide(color: AppColors.primary, width: 2)),
                    hintText: '0',
                    labelText: 'Preço',
                    labelStyle:
                        TextStyle(fontSize: 20, color: AppColors.primary)),
                onChanged: (value) {},
                inputFormatters: [
              LengthLimitingTextInputFormatter(7),
              // ignore: deprecated_member_use
              WhitelistingTextInputFormatter.digitsOnly,
              // ignore: deprecated_member_use
              BlacklistingTextInputFormatter.singleLineFormatter,
              new CurrencyInputFormatter()
            ]))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (_) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.black12,
              title: Text('Bem vindo ${controller.user.name}'),
              floating: true,
              snap: true,
              actions: [
                PopupMenuButton<int>(
                    icon: Icon(MdiIcons.filterMenuOutline),
                    elevation: 10,
                    itemBuilder: (context) => <PopupMenuEntry<int>>[
                          PopupMenuItem(child: Text('Data'), value: 0),
                          PopupMenuItem(child: Text('Preço'), value: 1),
                          PopupMenuItem(
                              child: Text('${controller.alfa[ordem]}'),
                              value: 2)
                        ],
                    onSelected: (result) {
                      switch (result) {
                        case 0:
                          _showDatePicker(context);
                          break;
                        case 1:
                          customDialog(context,
                              title: 'Flitter de Preço', content: _textfied());
                          break;
                        case 2:
                          ordem = !ordem;
                          break;
                      }
                    }),
              ],
            ),
            SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  if (index ==
                          controller.listProdut.length -
                              controller.pageProdut['pass_page'] &&
                      controller.pageProdut["has_more"]) {
                    print(
                        '$index == ${controller.listProdut.length} - ${controller.pageProdut['pass_page']} - ${(controller.listProdut.length - controller.pageProdut['pass_page'])}');
                    controller.getProduts();
                  }
                  if (index == controller.listProdut.length &&
                      controller.pageProdut["has_more"]) {
                    if (controller.pageProdut["error"]) {
                      return Center(
                        child: InkWell(
                          onTap: () {
                            setState(
                              () {
                                controller.pageProdut['loading'] = true;
                                controller.pageProdut['error'] = false;
                                controller.getProduts();
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
                                      AppColors.loading))));
                    }
                  }
                  return Text(
                      '${controller.listProdut[index].name} - $index - ${controller.listProdut[index].id}');
                }, childCount: controller.pageProdut['total_page']),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 1.0,
                  childAspectRatio: .58,
                ))
          ],
        );
      }),
      /* floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ), */
    );
  }
}
