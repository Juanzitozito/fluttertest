import 'package:hive_flutter/adapters.dart';

part 'orcamento.g.dart';

@HiveType(typeId: 2)
class Orcamento extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  double valorPrevisao;

  @HiveField(2)
  DateTime dataPrevisao;

  @HiveField(3)
  String categoria;

  Orcamento(
      {required this.id,
      required this.valorPrevisao,
      required this.dataPrevisao,
      required this.categoria});
}
