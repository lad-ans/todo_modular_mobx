import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_mobx2/app/core/shared/widgets/custom_icon_button.dart';
import 'package:todo_mobx2/app/core/shared/widgets/custom_textfield.dart';
import 'package:todo_mobx2/app/modules/login/stores/login_store.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginStore loginStore = LoginStore();

  // make reaction dispose to stop infinity loginStore.isLoggedIn value
  ReactionDisposer disposer;

  @override
  void didChangeDependencies() {
    // reaction
    super.didChangeDependencies();
    // autorun((_) {
    //   if (loginStore.isLoggedIn) {
    //     Modular.link.pushNamed("/home");
    //   }
    // });

    disposer = reaction((fn) {
      return loginStore.isLoggedIn;
    }, (loggedIn) {
      Modular.link.pushNamed("/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green,
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(32),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 16,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Observer(builder: (context) {
                      return CustomTextField(
                        hint: 'E-mail',
                        prefix: Icon(Icons.account_circle),
                        textInputType: TextInputType.emailAddress,
                        onChanged: loginStore.setEmail,
                        enabled: !loginStore.isLoading,
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    Observer(builder: (context) {
                      return CustomTextField(
                        hint: 'Senha',
                        prefix: Icon(Icons.lock),
                        obscure: loginStore.isPasswordShowen,
                        onChanged: loginStore.setPassword,
                        enabled: !loginStore.isLoading,
                        suffix: CustomIconButton(
                          radius: 32,
                          iconData: loginStore.isPasswordShowen
                              ? Icons.visibility
                              : Icons.visibility_off,
                          onTap: loginStore.changePasswordObscureState,
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 44,
                      child: Observer(builder: (context) {
                        return RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: loginStore.isLoading
                                ? CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  )
                                : Text('Login'),
                            color: Theme.of(context).primaryColor,
                            disabledColor:
                                Theme.of(context).primaryColor.withAlpha(100),
                            textColor: Colors.white,
                            onPressed: loginStore.loginPressed);
                      }),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }
}
