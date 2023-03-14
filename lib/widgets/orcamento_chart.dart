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

/*    final series = charts.Series(
    id: 'chartOrcamento',
    data: ,
    domainFn: ,
    measureFn: ,
  ); */

  @override
  Widget build(BuildContext context) {
    final values = categorias.map((e) {
      final previsaocat = orcamentos.where((e1) => e.id == e1.idCategoria);
      double totallancamentos = 0;
      for (var i in lancamentos) {
        if (i.categoria == e.nome) {
          totallancamentos += i.valor;
        }
      }

      return ChartData(
          id: Random().nextInt(999999999),
          categoria: e.nome,
          previsao: previsaocat.first.valorPrevisao,
          gasto: totallancamentos);
    }).toList();

/*     values.forEach((element) {
      print(element.id);
      print(element.gasto);
      print(element.categoria);
      print(element.previsao);
    }); */

    final series = [
      charts.Series(
        id: 'Chart',
        data: values,
        domainFn: (datum, index) => datum.categoria,
        measureFn: (datum, index) => datum.gasto,
      ),
    ];
    return charts.BarChart(
      series,
      animate: true,
    );
  }
}
