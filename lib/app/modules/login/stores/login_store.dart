import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  // _LoginStoreBase() {
  //   // chamada sempre que há alteração na variável observável
  //   autorun((_) {
  //     print(email);
  //   });
  // }

  @observable
  String email = "";

  @observable
  String password = "";

  @observable
  bool isPasswordShowen = false;

  @observable
  bool isLoading = false;

  @observable
  bool isLoggedIn = false;

  @action
  void setEmail(String value) => this.email = value;

  @action
  setPassword(String pass) => this.password = pass;

  @action
  void changePasswordObscureState() {
    isPasswordShowen = !isPasswordShowen;
  }

  @action
  Future<void> login() async {
    isLoading = true;
    await Future.delayed(Duration(seconds: 3));
    isLoading = false;
    isLoggedIn = true;
    email = "";
    password = "";
  }

  @action
  void logout() {
    isLoggedIn = true;
    print("SAIU");
  }

  @computed
  bool get isEmailValid => email.contains("@");

  @computed
  bool get isPasswordValid => password.length > 6;

  @computed
  VoidCallback get loginPressed =>
      (isEmailValid && isPasswordValid && !isLoading) ? login : null;

  // cobina os observables
  // @computed
  // bool get isFormValid => email.length > 6 && password.length > 6;

}
