import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertest/boxes.dart';
import 'package:fluttertest/entity/categoria.dart';
import 'package:fluttertest/entity/orcamento.dart';
import 'package:fluttertest/widgets/listagem_previsao.dart';
import 'package:hive_flutter/adapters.dart';

class PrevisaoDeGastos extends StatefulWidget {
  const PrevisaoDeGastos(this.addOrcamento, {super.key});

  final Function addOrcamento;

  @override
  State<PrevisaoDeGastos> createState() => _PrevisaoDeGastosState();
}

class _PrevisaoDeGastosState extends State<PrevisaoDeGastos> {
  final _valorOrcamento = TextEditingController();

  int? _value;
  DateTime? data;
  var box = Hive.box<Categoria>('categorias');
  var trueBox = Hive.box<Orcamento>('orcamentos');

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
                      child: ElevatedButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2018, 3),
                              maxTime: DateTime(2023, 12),
                              onChanged: (date) {}, onConfirm: (date) {
                            setState(() {
                              data = date;
                            });
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.pt);
                        },
                        child: const Text('vamo pra sima gremio'),
                      ),
                    ),
                    (data != null) ? Text(data.toString()) : const Text('aaa'),
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
                  return ListagemPrevisoes(box.values.toList());
                }),
          ],
        ),
      ),
    );
  }
}
