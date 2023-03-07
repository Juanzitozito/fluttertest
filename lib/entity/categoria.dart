import 'package:hive/hive.dart';

part 'categoria.g.dart';

@HiveType(typeId: 0)
class Categoria extends HiveObject {
  @HiveField(0)
  late int? id;

  @HiveField(1)
  late String nome;

  @HiveField(2)
  late Map? orcamento;

  Categoria({this.id, required this.nome, this.orcamento});

  getId() {
    return id;
  }

  void setId(id) {
    this.id = id;
  }
}
