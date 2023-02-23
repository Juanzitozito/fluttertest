import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class NewLancamento extends StatelessWidget {
  final Function addInput;
  final observacaoController = TextEditingController();
  final valorController = TextEditingController();
  final categoriaController = TextEditingController();
  final emissaoController = TextEditingController();

  NewLancamento(this.addInput, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(8),
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
            TextField(
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
                      emissaoController.text);
                },
                child: Text('adicionar'))
          ],
        ),
      ),
    );
  }
}
