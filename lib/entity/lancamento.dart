class Lancamento {
  int? id;
  DateTime? emissao;
  double valor;
  String observacao;
  String? categoria;

  Lancamento(
      {this.id,
      this.emissao,
      required this.valor,
      required this.observacao,
      this.categoria});
}
