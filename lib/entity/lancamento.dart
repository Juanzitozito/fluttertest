class Lancamento {
  int? id;
  DateTime emissao;
  double valor;
  String observacao;
  String categoria;

  Lancamento(
      {this.id,
      required this.emissao,
      required this.valor,
      required this.observacao,
      required this.categoria});
}
