import 'package:flutter/material.dart';
import 'package:fluttertest/boxes.dart';
import 'package:fluttertest/entity/categoria.dart';
import 'package:fluttertest/widgets/lista_categorias.dart';
import 'package:fluttertest/widgets/new_categorias.dart';
import 'package:hive_flutter/adapters.dart';

class Categorias extends StatefulWidget {
  const Categorias({super.key});

  @override
  State<Categorias> createState() => _CategoriasState();
}

class _CategoriasState extends State<Categorias> {
  final List<Categoria> _listaCategorias = [
    Categoria(id: 1, nome: 'automóveis'),
    Categoria(id: 2, nome: 'jogos'),
    Categoria(id: 3, nome: 'cosméticos'),
  ];

  void _addNewCategoria(String nome) {
    final newCat = Categoria(nome: nome, id: UniqueKey().hashCode);

    final box = Boxes.getCategorias();
    box.add(newCat);
  }

  void _startAddCategoria(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewCategoria(_addNewCategoria);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAddCategoria(context);
        },
      ),
      appBar: AppBar(
        title: const Text('categorias'),
      ),
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(30),
          child: Card(
              elevation: 10,
              child: ValueListenableBuilder<Box<Categoria>>(
                valueListenable: Boxes.getCategorias().listenable(),
                builder: (context, box, _) {
                  final categorias = box.values.toList().cast<Categoria>();

                  return ListaCategorias(categorias);
                },
              ))),
    );
  }
}
