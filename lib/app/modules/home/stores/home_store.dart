import 'package:mobx/mobx.dart';
import 'package:todo_mobx2/app/modules/home/stores/todo_store.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  @observable
  String newTodoTitle = "";

  @observable
  bool isTodoEmpty = true;

  @action
  void setNewTodoTitle(String value) => newTodoTitle = value;

  @computed
  get isFormValid => newTodoTitle.isNotEmpty;

  ObservableList<TodoStore> todoList = ObservableList<TodoStore>();

  @action
  void addTodo() {
    // quando não for adicionado assim o elemento, o observable só observará a primeira instância da Lista: List
    todoList.insert(0, TodoStore(newTodoTitle));
    newTodoTitle = "";
  }
}
