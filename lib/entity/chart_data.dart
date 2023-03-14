class ChartData {
  int id;

  String categoria;

  double? previsao;

  double? gasto;

  ChartData(
      {required this.id, required this.categoria, this.previsao, this.gasto});
}
