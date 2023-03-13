import 'package:flutter/material.dart';

import '../widgets/orcamento_chart.dart';

class ConsultasOrcamento extends StatelessWidget {
  ConsultasOrcamento({super.key});

  final month = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de Orçamentos'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: /* OrcamentoChart(month) */ Container(),
      ),
    );
  }
}
