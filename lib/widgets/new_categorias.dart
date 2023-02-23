import 'package:flutter/material.dart';

class NewCategoria extends StatelessWidget {
  final nomeController = TextEditingController();
  final Function addInput;

  NewCategoria(this.addInput, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'nome'),
            controller: nomeController,
          ),
          ElevatedButton(
              onPressed: () {
                addInput(nomeController.text);
              },
              child: const Text('adicionar'))
        ],
      ),
    );
  }
}
