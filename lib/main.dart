import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertest/entity/categoria.dart';
import 'package:fluttertest/entity/lancamento.dart';
import 'package:fluttertest/widgets/lista_lancamento.dart';
import 'package:fluttertest/widgets/new_lancamento.dart';
import 'package:intl/intl.dart';

void main(List<String> args) {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Categoria> _listaCategorias = [
    Categoria(id: 1, nome: 'automóveis'),
    Categoria(id: 2, nome: 'jogos'),
    Categoria(id: 3, nome: 'cosméticos')
  ];

  final List<Lancamento> _listaLancamentos = [
    Lancamento(
        id: 1,
        emissao: DateTime.now(),
        valor: 29.99,
        observacao: 'description',
        categoria: 'jogos'),
    Lancamento(
        id: 2,
        emissao: DateTime.now(),
        valor: 39.45,
        observacao: 'brief explanation',
        categoria: 'automóveis')
  ];

  void _addNewLancamento(String observacao, double valor, String categoria) {
    final newLanc = Lancamento(
        emissao: DateTime.now(),
        valor: valor,
        observacao: observacao,
        categoria: categoria,
        id: UniqueKey().hashCode);

    setState(() {
      _listaLancamentos.add(newLanc);
    });
  }

  void _startAddLancamento(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewLancamento(_addNewLancamento);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My expenses app'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.black38,
            width: double.infinity,
            child: (Card(
              child: Row(
                children: _listaCategorias.map((e) {
                  return Column(
                    children: [Text(e.nome)],
                  );
                }).toList(),
              ),
            )),
          ),
          ListaLancamentos(_listaLancamentos),
          FloatingActionButton(
            onPressed: () => _startAddLancamento(context),
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
