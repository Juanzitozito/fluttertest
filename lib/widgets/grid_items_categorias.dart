import 'package:flutter/material.dart';
import 'package:fluttertest/entity/categoria.dart';

class ItensCategoria extends StatelessWidget {
  final int? id;
  final String nome;
  final Function deleteCategoria;
  final List<Categoria> listaCategorias;

  var teste;

  ItensCategoria(
      this.id, this.nome, this.deleteCategoria, this.listaCategorias);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Center(
                child: Text(
              nome,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w300,
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      listaCategorias.retainWhere((e) => e.id == id);
                      return deleteCategoria(listaCategorias[0]);
                    },
                    icon: const Icon(Icons.delete)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
