import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/entity/categoria.dart';
import 'package:select_form_field/select_form_field.dart';

class NewLancamento extends StatelessWidget {
  final Function addInput;
  final opcoesCategorias;
  final observacaoController = TextEditingController();
  final valorController = TextEditingController();
  final categoriaController = TextEditingController();
  final emissaoController = TextEditingController();

  final List<Map<String, dynamic>> _itens = [
    {
      'value': 'boxValue',
      'label': 'Box Label',
      'icon': Icon(Icons.stop),
    },
    {
      'value': 'circleValue',
      'label': 'Circle Label',
      'icon': Icon(Icons.fiber_manual_record),
      'textStyle': TextStyle(color: Colors.red),
    },
    {
      'value': 'starValue',
      'label': 'Star Label',
      'enable': false,
      'icon': Icon(Icons.grade),
    },
  ];

  NewLancamento(this.addInput, this.opcoesCategorias, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Observação'),
              controller: observacaoController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Valor'),
              controller: valorController,
            ),
            SelectFormField(
              items: opcoesCategorias.map((e) {
                return {'value': e.nome, 'label': e.nome}.cast();
              }).toList(),
              decoration:
                  const InputDecoration(labelText: 'Categoria do Produto'),
              controller: categoriaController,
            ),
            DateTimeField(
                onDateSelected: (date) {
                  emissaoController.text = date.toString();
                },
                selectedDate: DateTime.now()),
            ElevatedButton(
                onPressed: () {
                  addInput(
                      observacaoController.text,
                      double.parse(valorController.text),
                      categoriaController.text,
                      emissaoController.text.toString());
                },
                child: Text('adicionar'))
          ],
        ),
      ),
    );
  }
}
