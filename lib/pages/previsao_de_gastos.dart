import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertest/boxes.dart';
import 'package:fluttertest/entity/categoria.dart';
import 'package:fluttertest/entity/orcamento.dart';
import 'package:fluttertest/widgets/listagem_previsao.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

class PrevisaoDeGastos extends StatefulWidget {
  const PrevisaoDeGastos(this.addOrcamento, {super.key});

  final Function addOrcamento;

  @override
  State<PrevisaoDeGastos> createState() => _PrevisaoDeGastosState();
}

class _PrevisaoDeGastosState extends State<PrevisaoDeGastos> {
  final _valorOrcamento = TextEditingController();

  int? _value;
  DateTime data = DateTime.now();
  var box = Hive.box<Categoria>('categorias');
  var trueBox = Hive.box<Orcamento>('orcamentos');

  void _deleteOrcamentos(id) {
    var item = trueBox.values.where((e) => e.id == id);

    item.first.delete();

    setState(() {});
  }

  Future<void> _onPressed({
    required BuildContext context,
    String? locale,
  }) async {
    final localeObj = locale != null ? Locale(locale) : null;
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: data,
      firstDate: DateTime(2019),
      lastDate: DateTime(2024),
      locale: localeObj,
    );

    if (selected != null) {
      setState(() {
        data = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('registro de previsões'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Card(
                elevation: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 100,
                      child: TextField(
                        decoration: const InputDecoration(
                            labelText: 'valor estipulado'),
                        controller: _valorOrcamento,
                      ),
                    ),
                    DropdownButton(
                        value: _value,
                        items: box.values
                            .map((e) => DropdownMenuItem(
                                  value: e.id,
                                  child: Text(e.nome),
                                ))
                            .toList(),
                        onChanged: (v) {
                          setState(() {
                            _value = v;
                          });
                        }),
                    SizedBox(
                      height: 20,
                      width: 100,
                      child: TextButton(
                        onPressed: () =>
                            _onPressed(context: context, locale: 'pt'),
                        child: const Text('data'),
                      ),
                    ),
                    Text(DateFormat().add_yM().format(data)),
                    ElevatedButton(
                        onPressed: () {
                          widget.addOrcamento(
                              _value, double.parse(_valorOrcamento.text), data);
                        },
                        child: const Text('Definir orçamento'))
                  ],
                ),
              ),
            ),
            ValueListenableBuilder<Box<Orcamento>>(
                valueListenable: Boxes.getOrcamentos().listenable(),
                builder: (context, box, _) {
                  return ListagemPrevisoes(
                      box.values.toList(), _deleteOrcamentos);
                }),
          ],
        ),
      ),
    );
  }
}
