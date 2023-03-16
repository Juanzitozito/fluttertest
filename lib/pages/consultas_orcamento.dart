import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../widgets/orcamento_chart.dart';

class ConsultasOrcamento extends StatefulWidget {
  const ConsultasOrcamento({super.key});

  @override
  State<ConsultasOrcamento> createState() => _ConsultasOrcamentoState();
}

class _ConsultasOrcamentoState extends State<ConsultasOrcamento> {
  var _selected = DateTime.now();

  Future<void> _onPressed({
    required BuildContext context,
    String? locale,
  }) async {
    final localeObj = locale != null ? Locale(locale) : null;
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: _selected,
      firstDate: DateTime(2019),
      lastDate: DateTime(2024),
      locale: localeObj,
    );

    if (selected != null) {
      setState(() {
        _selected = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de Orçamentos'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Card(
                elevation: 10,
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () =>
                          _onPressed(context: context, locale: 'pt'),
                      child: const Text('Selecionar data'),
                    ),
                    Text(DateFormat().add_yM().format(_selected)),
                  ],
                )),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                child: OrcamentoChart(_selected)),
          ],
        ),
      ),
    );
  }
}
