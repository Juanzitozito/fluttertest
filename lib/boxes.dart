import 'package:fluttertest/entity/categoria.dart';
import 'package:fluttertest/entity/lancamento.dart';
import 'package:hive_flutter/adapters.dart';

class Boxes {
  static Box<Lancamento> getLancamentos() =>
      Hive.box<Lancamento>('lancamentos');

  static Box<Categoria> getCategorias() => Hive.box<Categoria>('categorias');
}
