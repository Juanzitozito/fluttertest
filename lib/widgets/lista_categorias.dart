import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/entity/categoria.dart';
import 'package:fluttertest/widgets/grid_items_categorias.dart';

class ListaCategorias extends ConsumerWidget {
  final List<Categoria> listaCategorias;
  final Function deleteCategorias;
/*   final Function editCategorias;
  final Function startEditCategoria; */

  const ListaCategorias(this.listaCategorias, this.deleteCategorias,
      /*  this.editCategorias, this.startEditCategoria, */
      {super.key});

  @override
  Widget build(BuildContext context, ref) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: listaCategorias.length,
      itemBuilder: (context, i) => ItensCategoria(
        listaCategorias[i].id,
        listaCategorias[i].nome,
        deleteCategorias,
        listaCategorias,
/*           editCategorias,
          startEditCategoria */
      ),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200, mainAxisSpacing: 15, crossAxisSpacing: 20),
    );
  }
}
