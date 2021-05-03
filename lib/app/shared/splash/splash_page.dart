import 'package:dex_control_product/app/shared/splash/splash_store.dart';
import 'package:dex_control_product/app/shared/useful/app_colors.dart';
import 'package:dex_control_product/app/shared/useful/screen_size.dart';
import 'package:dex_control_product/app/shared/useful/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashPage extends StatefulWidget {
  final String title;
  const SplashPage({Key? key, this.title = 'SplashPage'}) : super(key: key);
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends ModularState<SplashPage, SplashStore> {
  @override
  void initState() {
    super.initState();
    controller.insertUseModel();
    controller.checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final ScreenSize size = ScreenSize(width: width, height: height);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.greenBlueGrayola,
          width: size.totalWidth(),
          height: size.totalHeight(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  width: width * .9,
                  height: width * .9,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/desafio.gif')))),
              Positioned(
                bottom: 10,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SpinKitCircle(
                            color: AppColors.loading,
                            size: size.resolutionMaxMin() ? 80 : 40),
                        Text('Bem Vindo!',
                            textAlign: TextAlign.center,
                            style: size.resolutionMaxMin()
                                ? StyleText.textTabletMonitors
                                : StyleText.textMobile,
                            maxLines: 2,
                            overflow: TextOverflow.fade),
                      ],
                    ),
                    Observer(builder: (_) {
                      return controller.status != ''
                          ? Text(controller.status,
                              textAlign: TextAlign.center,
                              style: StyleText.textField,
                              maxLines: 2,
                              overflow: TextOverflow.fade)
                          : Container();
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
