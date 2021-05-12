import 'package:dex_control_product/app/shared/useful/app_colors.dart';
import 'package:dex_control_product/app/shared/useful/text_style.dart';
import 'package:dex_control_product/app/shared/widget/custom_load_button.dart';
import 'package:dex_control_product/app/shared/widget/custom_text_field.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import 'login_store.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ModularState<LoginPage, LoginStore> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: Colors.white,
      body: Observer(
        builder: (_) {
          return Form(
            key: controller.formKey,
            child: ListView(
              padding: EdgeInsets.all(width * 0.05),
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: height * .08, bottom: height * .03),
                    width: width > 600.0 ? width * .5 : width * .7,
                    height: width > 600.0 ? width * .5 : width * .7,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 3),
                        image: DecorationImage(
                            fit: BoxFit.none,
                            image: AssetImage('assets/images/logo.jpg')))),
                CustomTextField(
                    label: 'Login',
                    hint: 'Digite o Login',
                    onFieldSubmitted: () {},
                    keyboardType: TextInputType.name,
                    controller: controller.ctrlLogin,
                    validator: controller.validaLogin),
                CustomTextField(
                    label: 'Senha',
                    hint: 'Digite a Senha',
                    onFieldSubmitted: () {},
                    controller: controller.ctrlSenha,
                    validator: controller.validaSenha,
                    visibility: controller.visibilityPassword,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                        icon: Icon(
                            controller.visibilityPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.greenBlueGrayola),
                        onPressed: () => controller.setvisibility())),
                CustomLoadButton(
                    width: width > 600.0 ? width * .10 : width * .16,
                    styleText: width > 600.0
                        ? StyleText.textAutoSizeButton
                        : StyleText.textButton,
                    txt: 'Entrar',
                    loading: controller.loading,
                    onPressed: () => controller.login()),
                Observer(builder: (_) {
                  return controller.status != ''
                      ? Text(controller.status,
                          textAlign: TextAlign.center,
                          style: StyleText.mdgLogin,
                          maxLines: 2,
                          overflow: TextOverflow.fade)
                      : Container();
                })
              ],
            ),
          );
        },
      ),
    );
  }
}
