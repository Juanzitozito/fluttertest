import 'package:hive/hive.dart';

part 'lancamento.g.dart';

@HiveType(typeId: 1)
class Lancamento extends HiveObject {
  @HiveField(2)
  int? id;

  @HiveField(3)
  DateTime emissao;

  @HiveField(4)
  double valor;

  @HiveField(5)
  String observacao;

  @HiveField(6)
  String categoria;

  Lancamento(
      {this.id,
      required this.emissao,
      required this.valor,
      required this.observacao,
      required this.categoria});

  getId() {
    return id;
  }

  void setId(id) {
    this.id = id;
  }
}
