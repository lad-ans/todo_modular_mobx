// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStoreBase, Store {
  Computed<dynamic> _$isFormValidComputed;

  @override
  dynamic get isFormValid =>
      (_$isFormValidComputed ??= Computed<dynamic>(() => super.isFormValid,
              name: '_HomeStoreBase.isFormValid'))
          .value;

  final _$newTodoTitleAtom = Atom(name: '_HomeStoreBase.newTodoTitle');

  @override
  String get newTodoTitle {
    _$newTodoTitleAtom.reportRead();
    return super.newTodoTitle;
  }

  @override
  set newTodoTitle(String value) {
    _$newTodoTitleAtom.reportWrite(value, super.newTodoTitle, () {
      super.newTodoTitle = value;
    });
  }

  final _$isTodoEmptyAtom = Atom(name: '_HomeStoreBase.isTodoEmpty');

  @override
  bool get isTodoEmpty {
    _$isTodoEmptyAtom.reportRead();
    return super.isTodoEmpty;
  }

  @override
  set isTodoEmpty(bool value) {
    _$isTodoEmptyAtom.reportWrite(value, super.isTodoEmpty, () {
      super.isTodoEmpty = value;
    });
  }

  final _$_HomeStoreBaseActionController =
      ActionController(name: '_HomeStoreBase');

  @override
  void setNewTodoTitle(String value) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.setNewTodoTitle');
    try {
      return super.setNewTodoTitle(value);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addTodo() {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.addTodo');
    try {
      return super.addTodo();
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
newTodoTitle: ${newTodoTitle},
isTodoEmpty: ${isTodoEmpty},
isFormValid: ${isFormValid}
    ''';
  }
}
