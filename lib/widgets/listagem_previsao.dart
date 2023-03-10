import 'package:flutter/material.dart';
import 'package:fluttertest/entity/orcamento.dart';

class ListagemPrevisoes extends StatelessWidget {
  final List<Orcamento> orcamentos;
  const ListagemPrevisoes(this.orcamentos, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: orcamentos.map((e) => Text(e.toString())).toList(),
      /* SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 20,
                child: Row(),
              ),
            ), */
    );
  }
}
