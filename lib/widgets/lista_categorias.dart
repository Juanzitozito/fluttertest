import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/entity/categoria.dart';
import 'package:fluttertest/main.dart';
import 'package:fluttertest/widgets/grid_items_categorias.dart';

class ListaCategorias extends ConsumerWidget {
  final List<Categoria> listaCategorias;
  final Function deleteCategorias;

  ListaCategorias(this.listaCategorias, this.deleteCategorias);

  @override
  Widget build(BuildContext context, ref) {
    final catego = ref.watch(listaDeCategorias);

    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: listaCategorias.length,
      itemBuilder: (context, i) => ItensCategoria(listaCategorias[i].id,
          listaCategorias[i].nome, deleteCategorias, listaCategorias),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200, mainAxisSpacing: 15, crossAxisSpacing: 20),
    );
  }
}
