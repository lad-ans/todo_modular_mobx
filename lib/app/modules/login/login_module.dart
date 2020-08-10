import 'package:todo_mobx2/app/modules/home/home_module.dart';
import 'package:todo_mobx2/app/modules/login/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => LoginPage()),
        Router("/home", module: HomeModule()),
      ];
}
