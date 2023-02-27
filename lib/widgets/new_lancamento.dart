import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class NewLancamento extends StatefulWidget {
  final Function addInput;
  final List opcoesCategorias;

  const NewLancamento(this.addInput, this.opcoesCategorias, {super.key});

  @override
  State<NewLancamento> createState() => _NewLancamentoState();
}

class _NewLancamentoState extends State<NewLancamento> {
  final observacaoController = TextEditingController();

  final valorController = TextEditingController();

  final categoriaController = TextEditingController();

  final emissaoController = TextEditingController();

  String? _value;

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
            DropdownButton<String>(
                value: _value,
                items: widget.opcoesCategorias.map((e) {
                  return DropdownMenuItem<String>(
                    value: e.nome,
                    child: Text(e.nome),
                  );
                }).toList(),
                onChanged: (String? v) {
                  setState(() {
                    _value = v;
                  });
                }),
            DateTimeField(
                onDateSelected: (date) {
                  emissaoController.text = date.toString();
                },
                selectedDate: DateTime.now()),
            ElevatedButton(
                onPressed: () {
                  widget.addInput(
                      observacaoController.text,
                      double.parse(valorController.text),
                      _value,
                      emissaoController.text.toString());
                },
                child: const Text('adicionar'))
          ],
        ),
      ),
    );
  }
}
