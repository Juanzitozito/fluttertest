import 'package:hive/hive.dart';

part 'categoria.g.dart';

@HiveType(typeId: 0)
class Categoria extends HiveObject {
  @HiveField(0)
  late int? id;

  @HiveField(1)
  late String nome;

  Categoria({this.id, required this.nome});

  getId() {
    return id;
  }

  void setId(id) {
    this.id = id;
  }
}
