import 'package:dex_control_product/app/modules/home/home_store.dart';
import 'package:dex_control_product/app/modules/home/widget/card_product.dart';
import 'package:dex_control_product/app/shared/models/product_model.dart';
import 'package:dex_control_product/app/shared/models/user_model.dart';
import 'package:dex_control_product/app/shared/useful/app_colors.dart';
import 'package:dex_control_product/app/shared/useful/text_style.dart';
import 'package:dex_control_product/app/shared/widget/custom_dialog.dart';
import 'package:dex_control_product/app/shared/widget/custom_dialog_button.dart';
import 'package:dex_control_product/app/shared/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget {
  final String title;
  final UserModel user;
  final List<ProductModel> products;
  const HomePage(
      {Key? key,
      this.title = "Home",
      required this.user,
      required this.products})
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
    controller.listProdut.addAll(widget.products);
  }

  Future<void> _showDatePicker(context, {int result = 0}) async {
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
    if (picked != null) controller.aplyFilter(value: picked, type: result);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Observer(builder: (_) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
                title: Text('Bem vindo ${controller.user.name}',
                    style: StyleText.labelTextField),
                floating: true,
                snap: true,
                actions: [
                  PopupMenuButton<int>(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10,top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(MdiIcons.filterMenuOutline),
                            Text('${controller.detailFilter}')
                          ],
                        ),
                      ),
                      elevation: 10,
                      itemBuilder: (context) => <PopupMenuEntry<int>>[
                            PopupMenuItem(child: Text('Data'), value: 0),
                            PopupMenuItem(child: Text('Preço'), value: 1),
                            PopupMenuItem(
                                child: Text('${controller.alfa[ordem]}'),
                                value: 2),
                            PopupMenuItem(
                                child: Text('Limpar Filtro'), value: 3),
                          ],
                      onSelected: (result) {
                        switch (result) {
                          case 0:
                            _showDatePicker(context, result: result);
                            break;
                          case 1:
                            customDialog(context,
                                title: 'Flitter de Preço',
                                content: CustomTextField(
                                    label: 'Preço',
                                    hint: '0,00',
                                    validator: () {},
                                    onChanged: (){},
                                    keyboardType: TextInputType.number,
                                    inputFormat: true,
                                    textAlign: TextAlign.center,
                                    controller: qtdController,
                                    onFieldSubmitted: (value) {
                                      if (value != '')
                                        controller.aplyFilter(
                                            value: value, type: result);
                                    }),
                                buttons: [
                                  CustomDialogButton(
                                      text: 'Aplicar',
                                      pop: true,
                                      onPressed: () {
                                        if (qtdController.text != '')
                                          controller.aplyFilter(
                                              value: qtdController.text,
                                              type: result);
                                      })
                                ]);
                            break;
                          case 2:
                            ordem = !ordem;
                            controller.aplyFilter(value: ordem, type: result);
                            break;
                          default:
                            controller.aplyFilter(value: '', type: result);
                        }
                      }),
                ]),
            controller.listProdut.length == 0
                ? SliverFixedExtentList(
                    itemExtent: height * .85,
                    delegate: SliverChildListDelegate(
                      [
                        Center(
                            child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text('Sem Produtos Cadastrados')))
                      ],
                    ),
                  )
                : SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      if (index ==
                              controller.listProdut.length -
                                  controller.pageProdut['pass_page'] &&
                          controller.pageProdut["has_more"]) {
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
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              AppColors.loading))));
                        }
                      }
                      return CardProduct(
                          product: controller.listProdut[index],
                          delteFunc: () => controller
                              .deleteProduct(controller.listProdut[index]),
                          details: () {
                            Modular.to.pushNamed('/home/product', arguments: [
                              controller.listProdut[index],
                              false
                            ]);
                          });
                    }, childCount: controller.listProdut.length),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 190.0,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 1.0,
                      childAspectRatio: .70,
                    ))
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          tooltip: 'Create',
          onPressed: () {
            ProductModel prod = ProductModel(
                codigo: 0,
                name: 'Novo Produto',
                price: 0.00,
                stock: 0.00,
                dateModify: Appformat.dateHifen.format(DateTime.now()));
            Modular.to.pushNamed('/home/product', arguments: [prod, true]);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        color: AppColors.greenBlueGrayola,
        child: Container(height: 40),
      ),
    );
  }
}
