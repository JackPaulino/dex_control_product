import 'package:dex_control_product/app/shared/useful/app_colors.dart';
import 'package:dex_control_product/app/shared/useful/screen_size.dart';
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

class LoginPageState extends State<LoginPage> {
  final LoginStore store = Modular.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final ScreenSize size = ScreenSize(width: width, height: height);
    return Scaffold(
      key: store.scaffoldKey,
      body: Observer(
        builder: (_) {
          return Form(
            key: store.formKey,
            child: ListView(
              padding: EdgeInsets.all(width * 0.05),
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: height * .08, bottom: height * .03),
                    width: size.resolutionMaxMin() ? width * .5 : width * .7,
                    height: size.resolutionMaxMin() ? width * .5 : width * .7,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 3),
                        image: DecorationImage(
                            fit: BoxFit.none,
                            image: AssetImage('assets/images/logo.png')))),
                /*  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: store.ctrlLogin,
                      obscureText: false,
                      validator: (value) => store.validaLogin(value!),
                      style: StyleText.labelTextField,
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: AppColors.greenBlueGrayola, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                                color: AppColors.greenBlueGrayola, width: 2)),
                        labelText: 'Login',
                        labelStyle:
                            TextStyle(color: AppColors.greenBlueGrayola),
                        hintText: 'Digite o Login',
                      ),
                    )), */
                CustomTextField(
                    label: 'Login',
                    hint: 'Digite o Login',
                    keyboardType: TextInputType.name,
                    controller: store.ctrlLogin,
                    validator: store.validaLogin),
                CustomTextField(
                    label: 'Senha',
                    hint: 'Digite a Senha',
                    controller: store.ctrlSenha,
                    validator: store.validaSenha,
                    password: true,
                    visibility: store.visibilityPassword,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                        icon: Icon(
                            store.visibilityPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.greenBlueGrayola),
                        onPressed: () {
                          setState(() {
                            store.setvisibility();
                          });
                        })),
                CustomLoadButton(
                    width: size.resolutionMaxMin() ? width * .10 : width * .16,
                    styleText: size.resolutionMaxMin()
                        ? StyleText.textAutoSizeButton
                        : StyleText.textButton,
                    txt: 'Entrar',
                    loading: store.loading,
                    onPressed: () {
                      store.login();
                    }),
                Observer(builder: (_) {
                  return store.status != ''
                      ? Text(store.status,
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
