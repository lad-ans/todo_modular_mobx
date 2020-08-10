import 'package:todo_mobx2/app/modules/home/home_page.dart';
import 'package:todo_mobx2/app/modules/login/login_module.dart';

import 'home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HomePage()),
        Router("/login", module:  LoginModule()),
      ];

}
