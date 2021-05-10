import 'package:auto_size_text/auto_size_text.dart';
import 'package:dex_control_product/app/modules/home/product/product_store.dart';
import 'package:dex_control_product/app/shared/models/product_model.dart';
import 'package:dex_control_product/app/shared/useful/app_colors.dart';
import 'package:dex_control_product/app/shared/useful/text_style.dart';
import 'package:dex_control_product/app/shared/widget/custom_load_button.dart';
import 'package:dex_control_product/app/shared/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:dex_control_product/app/shared/widget/custom_icon_button.dart';
import 'dart:convert';

class ProductPage extends StatefulWidget {
  final String title;
  final ProductModel product;
  const ProductPage(
      {Key? key, this.title = "Detalhes do Produto", required this.product})
      : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends ModularState<ProductPage, ProductStore> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    controller.product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Observer(
          builder: (_) {
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .94,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                    child: Column(
                      children: [
                        Stack(alignment: Alignment.center, children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Hero(
                                tag: controller.product.id.toString(),
                                child: controller.product.image != null
                                    ? Image.memory(
                                        base64Decode(
                                            '${controller.product.image}'),
                                        fit: BoxFit.contain,
                                        width: width * .80,
                                        height: width * .80,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Image.asset(
                                                    'assets/images/erro.jpg',
                                                    width: width * .90,
                                                    height: width * .90))
                                    : Image.asset('assets/images/notimg.jpg',
                                        width: width * .80,
                                        height: width * .80)),
                          ),
                          Positioned(
                              left: 0,
                              bottom: 0,
                              child: Text(
                                'imagem meramente ilustrativa',
                                style: TextStyle(
                                    color: AppColors.primary, fontSize: 12),
                              )),
                          Positioned(
                              top: 10,
                              right: 0,
                              child: IconButton(
                                  color: Colors.green,
                                  icon: Icon(MdiIcons.cameraPlus, size: 35),
                                  onPressed: () => controller.setImage())),
                        ]),
                        AutoSizeText('${controller.product.name}',
                            maxLines: 2,
                            presetFontSizes: [30, 20, 18, 16],
                            textAlign: TextAlign.center,
                            minFontSize: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomIconButton(
                                text: 'Excluir',
                                icon:
                                    Icon(MdiIcons.delete, color: Colors.white),
                                ativeButton: true,
                                onPressed: () {
                                  Modular.to.pop();
                                  controller.homeStore
                                      .deleteProduct(controller.product);
                                }),
                            Column(
                              children: [
                                AutoSizeText(
                                  widget.product.stock! <= 0
                                      ? 'Indisponível'
                                      : '${Appformat.moneyR$.format(controller.product.price)}',
                                  minFontSize: 35,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                AutoSizeText.rich(
                                    TextSpan(
                                        text: 'Estoque: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal),
                                              text:
                                                  '${Appformat.quantity.format(controller.product.price)}')
                                        ]),
                                    minFontSize: 20),
                              ],
                            ),
                            CustomIconButton(
                                text: 'Editar',
                                icon: Icon(Icons.edit_outlined,
                                    color: Colors.white),
                                ativeButton: true,
                                onPressed: () {
                                  setState(() => controller.setEdit());
                                })
                          ],
                        ),
                        SizedBox(height: 10)
                      ],
                    ),
                  ),
                ),
                Observer(builder: (_) {
                  return controller.edit
                      ? Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Form(
                            key: controller.productForm,
                            child: Column(
                              children: [
                                CustomTextField(
                                    label: 'Nome',
                                    hint: 'Nome do Produto',
                                    validator: () {},
                                    keyboardType: TextInputType.streetAddress,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    controller: controller.nameController,
                                    onFieldSubmitted: (value) {}),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                          label: 'Preço',
                                          hint: '0,00',
                                          validator: () {},
                                          keyboardType: TextInputType.number,
                                          controller:
                                              controller.priceController,
                                          onFieldSubmitted: (value) {}),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: CustomTextField(
                                          label: 'Estoque',
                                          hint: '0,00',
                                          validator: () {},
                                          keyboardType: TextInputType.number,
                                          controller:
                                              controller.stockController,
                                          onFieldSubmitted: (value) {}),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: width,
                                  child: CustomLoadButton(
                                      width: width * .16,
                                      styleText: StyleText.textButton,
                                      txt: 'Salvar',
                                      loading: controller.loading,
                                      onPressed: () {
                                        if (controller.productForm.currentState!
                                            .validate()) print('Valide');
                                      }),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container();
                })
              ],
            );
          },
        ),
      ),
    );
  }
}
