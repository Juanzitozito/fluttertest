import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/entity/lancamento.dart';

class NewLancamento extends StatefulWidget {
  final Function addInput;
  final List opcoesCategorias;
  final Lancamento? editingElement;

  const NewLancamento(
      {required this.addInput,
      required this.opcoesCategorias,
      this.editingElement,
      super.key});

  @override
  State<NewLancamento> createState() => _NewLancamentoState();
}

class _NewLancamentoState extends State<NewLancamento> {
  final observacaoController = TextEditingController();

  final valorController = TextEditingController();

  final categoriaController = TextEditingController();

  final emissaoController = TextEditingController();

  String? _value;
  DateTime? _data = DateTime.now();

  @override
  void initState() {
    if (widget.editingElement != null) {
      valorController.text = widget.editingElement?.valor.toString() ?? '';
      _value = widget.editingElement?.categoria ?? '';
      _data = widget.editingElement?.emissao ?? DateTime.now();
      observacaoController.text =
          widget.editingElement?.observacao.toString() ?? '';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(_value);
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(30),
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
                  _data = date;
                  setState(() {});
                },
                selectedDate: _data),
            ElevatedButton(
                onPressed: () {
                  (widget.editingElement != null)
                      ? widget.addInput(
                          widget.editingElement,
                          observacaoController.text,
                          double.parse(valorController.text),
                          _value,
                          emissaoController.text.toString())
                      : widget.addInput(
                          observacaoController.text,
                          double.parse(valorController.text),
                          _value,
                          _data.toString());
                },
                child: const Text('adicionar'))
          ],
        ),
      ),
    );
  }
}
