import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_mobx2/app/core/shared/widgets/custom_icon_button.dart';
import 'package:todo_mobx2/app/core/shared/widgets/custom_textfield.dart';
import 'package:todo_mobx2/app/modules/home/stores/home_store.dart';
import 'package:todo_mobx2/app/modules/login/login_page.dart';
import 'package:todo_mobx2/app/modules/login/stores/login_store.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  HomeStore homeStore = HomeStore();

  // dependência injectada
  final loginStore = Modular.get<LoginStore>();

  ReactionDisposer reactionDisposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reactionDisposer = reaction((fn) => loginStore.isLoggedIn,
        (effect) => Modular.link.pushNamed("/login"));
    // autorun((_) {
    //   print(loginStore.isLoggedIn);
    //   if (loginStore.isLoggedIn)
    //     Modular.link.pushNamed("/login");
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green,
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: const EdgeInsets.fromLTRB(32, 0, 32, 32),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Tarefas',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 32),
                    ),
                    Observer(builder: (_) {
                      return IconButton(
                        icon: Icon(Icons.exit_to_app),
                        color: Colors.white,
                        onPressed: loginStore.logout,
                      );
                    }),
                  ],
                ),
              ),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 16,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Observer(builder: (_) {
                      return Column(
                        children: <Widget>[
                          CustomTextField(
                            controller: controller,
                            hint: 'Tarefa',
                            onChanged: homeStore.setNewTodoTitle,
                            suffix: !homeStore.isFormValid
                                ? Container(width: 0.0, height: 0.0)
                                : CustomIconButton(
                                    radius: 32,
                                    iconData: Icons.add,
                                    onTap: () {
                                      homeStore.addTodo();
                                      // contornar o erro de controller.clear()
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        controller.clear();
                                      });
                                    },
                                  ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Expanded(
                            child: Observer(builder: (context) {
                              return ListView.separated(
                                itemCount: homeStore.todoList.length,
                                itemBuilder: (_, index) {
                                  final todo = homeStore.todoList[index];
                                  return Observer(builder: (_) {
                                    return ListTile(
                                      title: Text(
                                        todo.title,
                                        style: TextStyle(
                                            color: todo.done
                                                ? Colors.grey
                                                : Colors.green,
                                            decoration: todo.done
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none),
                                      ),
                                      onTap: todo.toogleDone,
                                    );
                                  });
                                },
                                separatorBuilder: (_, __) {
                                  return Divider();
                                },
                              );
                            }),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    reactionDisposer();
    super.dispose();
  }
}
