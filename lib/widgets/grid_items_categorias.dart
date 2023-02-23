import 'package:flutter/material.dart';
import 'package:fluttertest/entity/categoria.dart';

class ItensCategoria extends StatelessWidget {
  final id;
  final String nome;

  ItensCategoria(this.id, this.nome);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Center(
            child: Text(
          nome,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w300,
          ),
        )),
      ),
    );
  }
}
