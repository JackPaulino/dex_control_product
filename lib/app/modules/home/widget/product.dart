import 'package:auto_size_text/auto_size_text.dart';
import 'package:dex_control_product/app/shared/models/product_model.dart';
import 'package:dex_control_product/app/shared/useful/app_colors.dart';
import 'package:dex_control_product/app/shared/useful/text_style.dart';
import 'package:flutter/material.dart';

class CardProduct extends StatefulWidget {
  final ProductModel product;
  final Function details;
  CardProduct({required this.product, required this.details});

  @override
  _CardProductState createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      margin: EdgeInsets.symmetric(horizontal: 2),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                  elevation: 5,
                  child: Hero(
                      tag: widget.product.name,
                      child: widget.product.name != 'null'
                          ? Image.network('assets/images/notimagem.jpg',
                              width: constraints.maxWidth * .90,
                              height: constraints.maxWidth * .90,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset('assets/images/notimagem.jpg',
                                      width: constraints.maxWidth * .90,
                                      height: constraints.maxWidth * .90))
                          : Image.asset('assets/images/notimagem.jpg',
                              width: constraints.maxWidth * .90,
                              height: constraints.maxWidth * .90))),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                child: AutoSizeText('${widget.product.name}',
                    maxLines: 2,
                    presetFontSizes: [20, 18, 16, 14, 12, 10, 8],
                    softWrap: true,
                    wrapWords: true,
                    style: TextStyle(color: AppColors.pineGreen),
                    textAlign: TextAlign.center),
              ),
              Container(
                  margin: EdgeInsets.only(top: 2),
                  height: constraints.maxHeight * .11,
                  width: constraints.maxWidth * .85,
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
                      widget.product.quant! <= 0
                          ? 'Indiponível'
                          : '${Appformat.moneyR$.format(widget.product.preco)}',
                      textAlign: TextAlign.center,
                      presetFontSizes: [24, 20, 18, 16],
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red))),
            ],
          );
        },
      ),
    );
  }
}
