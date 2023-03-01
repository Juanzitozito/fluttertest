import 'package:flutter/material.dart';
import 'package:fluttertest/boxes.dart';
import 'package:pie_chart/pie_chart.dart';

class Consultas extends StatefulWidget {
  Consultas({super.key});

  @override
  State<Consultas> createState() => _ConsultasState();
}

class _ConsultasState extends State<Consultas> {
  final Map<String, double> itens = {};
  final boxCategorias = Boxes.getCategorias().values.toList();
  final boxLancamentos = Boxes.getLancamentos().values.toList();
  @override
  void initState() {
    super.initState();
    for (var i in boxCategorias) {
      double total = 0;
      for (var i2 in boxLancamentos) {
        if (i.nome == i2.categoria) {
          total += i2.valor;
        }
      }
      itens[i.nome] = total;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => print(itens),
      ),
      appBar: AppBar(
        title: const Text('consultas'),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: PieChart(
            dataMap: itens,
          )),
    );
  }
}
