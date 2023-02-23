import 'package:flutter/material.dart';
import 'package:fluttertest/entity/categoria.dart';
import 'package:fluttertest/widgets/grid_items_categorias.dart';

class ListaCategorias extends StatelessWidget {
  final List<Categoria> listaCategorias;

  ListaCategorias(this.listaCategorias);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: listaCategorias.length,
      itemBuilder: (context, i) =>
          ItensCategoria(listaCategorias[i].id, listaCategorias[i].nome),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200, mainAxisSpacing: 15, crossAxisSpacing: 20),

      /* Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: listaCategorias
            .map(
              (e) => Column(
                children: [
                  Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Text(
                        e.nome,
                        style: const TextStyle(color: Colors.white),
                      )),
                ],
              ),
            )
            .toList(),
      ), */
    );
  }
}
