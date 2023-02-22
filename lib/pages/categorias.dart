import 'package:flutter/material.dart';
import 'package:fluttertest/entity/categoria.dart';

class Categorias extends StatelessWidget {
  final List<Categoria>? listaCategorias;

  Categorias({this.listaCategorias});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('categorias'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(30),
        child: Card(
            elevation: 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: listaCategorias!
                  .map((e) => Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Text(
                        e.nome,
                        style: const TextStyle(color: Colors.white),
                      )))
                  .toList(),
            )),
      ),
    );
  }
}
