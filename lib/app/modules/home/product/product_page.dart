import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dex_control_product/app/modules/home/product/product_store.dart';
import 'package:dex_control_product/app/shared/models/product_model.dart';
import 'package:dex_control_product/app/shared/useful/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

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
  late File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(6),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () => getImage(),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60))),
                      child: Column(
                        children: [
                          Container(
                              height: constraints.maxHeight * .35,
                              width: constraints.maxWidth * .85,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Hero(
                                      tag: widget.product.name,
                                      child: widget.product.name != 'null'
                                          ? Image.asset(
                                              'assets/images/notimagem.jpg',
                                              width: constraints.maxWidth * .80,
                                              height:
                                                  constraints.maxWidth * .80,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Image.asset(
                                                      'assets/images/erro.jpg',
                                                      width:
                                                          constraints.maxWidth *
                                                              .90,
                                                      height:
                                                          constraints.maxWidth *
                                                              .90))
                                          : Image.asset(
                                              'assets/images/notimagem.jpg',
                                              width: constraints.maxWidth * .80,
                                              height:
                                                  constraints.maxWidth * .80)),
                                  Positioned(
                                      right: 1,
                                      bottom: 10,
                                      child: Text(
                                        'imagem meramente ilustrativa',
                                        style: TextStyle(
                                            color: AppColors.primary,
                                            fontSize: 12),
                                      )),
                                ],
                              )),
                          /*  Column(
                            children: [
                              Observer(
                                builder: (_) {
                                  return widget.product.qtdEstoque <= 0
                                      ? Container()
                                      : widget.product.oferta == "S" &&
                                              widget.product.pVenda !=
                                                  controller.poffer
                                          ? AutoSizeText(
                                              '${Appformat.moneyR$.format(controller.pvend)}',
                                              minFontSize: 18,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColors.primary,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            )
                                          : Container();
                                },
                              ),
                              Observer(builder: (_) {
                                return AutoSizeText(
                                  widget.product.qtdEstoque <= 0
                                      ? 'Indisponível'
                                      : '${Appformat.moneyR$.format(controller.poffer)}',
                                  minFontSize: 32,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }),
                            ],
                          ),
                          widget.product.qtdEstoque <= 0
                              ? Container()
                              : widget.product.tipoPoferta != 'L'
                                  ? widget.product.ofertasProduto.length > 0
                                      ? AutoSizeText(
                                          '${controller.checkOferta(widget.product.ofertasProduto[0], widget.product.unidade)}',
                                          minFontSize: 18,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : Container()
                                  : Column(
                                      children: widget.product.ofertasProduto
                                          .where((e) => e.tipoPoferta == 'L')
                                          .map<Widget>((off) {
                                        return AutoSizeText(
                                          '${controller.checkOferta(off, widget.product.unidade)}',
                                          minFontSize: 18,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      }).toList(),
                                    ), */
                          AutoSizeText(
                            widget.product.name,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            minFontSize: 20,
                          ),
                          /* Container(
                            margin: EdgeInsets.all(6),
                            width: constraints.maxWidth * .9,
                            height: constraints.maxWidth * .5,
                            padding: EdgeInsets.all(0),
                            color: Colors.transparent,
                            child: ProductButtonbar(
                                product: widget.product,
                                addQuant: widget.product.qtdEstoque <= 0
                                    ? null
                                    : () {
                                        widget.product.unidade == 'KG'
                                            ? widget.product.quantCompra += 0.1
                                            : widget.product.quantCompra++;
                                        if (widget.product.oferta == 'S')
                                          controller
                                              .refreshPoffer(widget.product);
                                      },
                                remQuant: widget.product.qtdEstoque <= 0
                                    ? null
                                    : () {
                                        if (widget.product.quantCompra > 0) {
                                          widget.product.unidade == 'KG'
                                              ? widget.product.quantCompra -= 0.1
                                              : widget.product.quantCompra--;
                                          if (widget.product.oferta == 'S')
                                            controller
                                                .refreshPoffer(widget.product);
                                        }
                                      },
                                addProd: widget.product.qtdEstoque <= 0
                                    ? null
                                    : () {
                                        if (widget.product.quantCompra > 0) {
                                          insertCard = true;
                                          controller.homeController.addProduct(
                                              product: widget.product);
                                          Modular.to.pop();
                                        }
                                      }),
                          ), */
                        ],
                      ),
                    ),
                  ),
                  /*  SeparatorBar(
                    title: 'Produtos Relacionados',
                  ),
                  Text('A Fazer - ProductPage.dart') */
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
