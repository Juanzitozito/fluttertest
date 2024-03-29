import 'package:flutter/material.dart';
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
  String? _value;
  DateTime data = DateTime.now();
  var box = Hive.box<Categoria>('categorias');
  var trueBox = Hive.box<Orcamento>('orcamentos');
  double _valorOrcamento = 0;

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
      body: SingleChildScrollView(
        child: SizedBox(
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
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: TextField(
                          decoration: const InputDecoration(
                              labelText: 'valor estipulado'),
                          onChanged: (v) => _valorOrcamento = double.parse(v),
                        ),
                      ),
                      DropdownButton(
                          value: _value,
                          items: box.values
                              .map((e) => DropdownMenuItem(
                                    value: e.nome,
                                    child: Text(e.nome),
                                  ))
                              .toList(),
                          onChanged: (v) {
                            setState(() {
                              _value = v;
                            });
                          }),
                      SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () =>
                                  _onPressed(context: context, locale: 'pt'),
                              child: const Text('data'),
                            ),
                            Text(DateFormat().add_yM().format(data)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: IconButton(
                          onPressed: () {
                            widget.addOrcamento(
                                _value ?? '', _valorOrcamento, data);
                          },
                          icon: const Icon(
                            Icons.add_box_outlined,
                            color: Colors.blue,
                            size: 40,
                          ),
                        ),
                      )
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
      ),
    );
  }
}
