import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dex_control_product/app/shared/models/product_model.dart';
import 'package:dex_control_product/app/shared/useful/app_colors.dart';
import 'package:dex_control_product/app/shared/useful/text_style.dart';
import 'package:dex_control_product/app/shared/widget/custom_dialog.dart';
import 'package:dex_control_product/app/shared/widget/custom_dialog_button.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CardProduct extends StatefulWidget {
  final ProductModel product;
  final Function details;
  final Function delteFunc;
  CardProduct(
      {required this.product, required this.details, required this.delteFunc});

  @override
  _CardProductState createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.details(),
      child: Container(
        color: Colors.black12,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints cons) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(children: [
                  Container(
                    child: Card(
                        elevation: 5,
                        child: Hero(
                            tag: widget.product.id.toString(),
                            child: widget.product.image != ''
                                ? Image.memory(
                                    base64Decode('${widget.product.image}'),
                                    fit: BoxFit.contain,
                                    width: cons.maxWidth * .80,
                                    height: cons.maxWidth * .80,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Container(
                                            width: cons.maxWidth * .80,
                                            height: cons.maxWidth * .80,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        'assets/images/erro.jpg')))))
                                : Container(
                                    width: cons.maxWidth * .80,
                                    height: cons.maxWidth * .80,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/notimg.jpg')))))),
                  ),
                  Positioned(
                      right: 0,
                      child: IconButton(
                          color: AppColors.primary,
                          icon: Icon(MdiIcons.delete, size: 25),
                          onPressed: () {
                            customDialog(context,
                                icon: Icon(MdiIcons.deleteAlert,
                                    size: 70, color: Colors.orangeAccent[700]),
                                content: Text('Deseja excluir o Produto?'),
                                buttons: [
                                  CustomDialogButton(
                                      text: 'Não',
                                      pop: true,
                                      onPressed: () {},
                                      confBtnColor: false),
                                  CustomDialogButton(
                                      text: 'Sim',
                                      pop: true,
                                      onPressed: () => widget.delteFunc())
                                ]);
                          }))
                ]),
                AutoSizeText('${widget.product.name}',
                    maxLines: 2,
                    presetFontSizes: [18, 16, 14, 12, 10, 8],
                    softWrap: true,
                    wrapWords: true,
                    style: TextStyle(color: AppColors.pineGreen),
                    textAlign: TextAlign.center),
                Container(
                    height: cons.maxHeight * .10,
                    width: cons.maxWidth * .80,
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 2,
                              spreadRadius: 0.2),
                        ]),
                    child: AutoSizeText(
                        widget.product.stock! <= 0
                            ? 'Indiponível'
                            : '${Appformat.moneyR$.format(widget.product.price)}',
                        textAlign: TextAlign.center,
                        presetFontSizes: [22, 20, 18, 16],
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red))),
              ],
            );
          },
        ),
      ),
    );
  }
}
