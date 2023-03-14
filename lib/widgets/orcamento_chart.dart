import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fluttertest/boxes.dart';
import 'package:fluttertest/entity/chart_data.dart';

class OrcamentoChart extends StatelessWidget {
  final DateTime month;
  OrcamentoChart(this.month, {super.key});

  final categorias = Boxes.getCategorias().values;
  final lancamentos = Boxes.getLancamentos().values;
  final orcamentos = Boxes.getOrcamentos().values;

  @override
  Widget build(BuildContext context) {
    final graphvalues = <ChartData>[];
    final values = categorias.map((e) {
      final previsaocat = orcamentos.where((e1) => e.id == e1.idCategoria);
      double totallancamentos = 0;
      for (var i in lancamentos) {
        if (i.categoria == e.nome) {
          totallancamentos += i.valor;
        }
      }

      graphvalues.add(ChartData(
          id: Random().nextInt(999999999),
          categoria: e.nome,
          valor: totallancamentos));

      graphvalues.add(ChartData(
          id: Random().nextInt(999999999),
          categoria: e.nome,
          valor: previsaocat.first.valorPrevisao));

      return graphvalues;
    }).toList();

/*     values.forEach((element) {
      print(element.id);
      print(element.gasto);
      print(element.categoria);
      print(element.previsao);
    }); */

    final series = [
      charts.Series<ChartData, String>(
        id: 'Chart',
        data: values[0],
        domainFn: (ChartData datum, index) => datum.categoria,
        measureFn: (ChartData datum, index) => datum.valor,
      ),
      charts.Series<ChartData, String>(
        id: 'Chart',
        data: values[1],
        domainFn: (ChartData datum, index) => datum.categoria,
        measureFn: (ChartData datum, index) => datum.valor,
      ),
    ];

    return charts.BarChart(
      series,
      animate: true,
    );
  }
}
