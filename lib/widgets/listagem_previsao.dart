import 'package:flutter/material.dart';
import 'package:fluttertest/boxes.dart';
import 'package:fluttertest/entity/orcamento.dart';

class ListagemPrevisoes extends StatelessWidget {
  final List<Orcamento> orcamentos;
  final categorias = Boxes.getCategorias().values;
  ListagemPrevisoes(this.orcamentos, {super.key});

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
                Text(
                    'limite: ${e.valorPrevisao.toStringAsFixed(2)}, ${categoria.first.nome}, ${e.dataPrevisao.toString()}'),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
