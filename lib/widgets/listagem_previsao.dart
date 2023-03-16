import 'package:flutter/material.dart';
import 'package:fluttertest/boxes.dart';
import 'package:fluttertest/entity/orcamento.dart';
import 'package:intl/intl.dart';

class ListagemPrevisoes extends StatelessWidget {
  final List<Orcamento> orcamentos;
  final categorias = Boxes.getCategorias().values;
  final Function _del;
  ListagemPrevisoes(this.orcamentos, this._del, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: orcamentos.map((e) {
        var categoria = categorias.where((e1) => e1.id == e.idCategoria);
        return SizedBox(
          width: double.infinity,
          child: Card(
            elevation: 20,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(5),
                  color: Colors.blue,
                  child: Text(
                    e.valorPrevisao.toStringAsFixed(2),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Text(
                  '${categoria.first.nome}, ${DateFormat.yM('pt').format(e.dataPrevisao).toString()}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 17),
                ),
                IconButton(
                  onPressed: () => _del(e.id),
                  icon: const Icon(Icons.delete),
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
