import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertest/entity/categoria.dart';
import 'package:fluttertest/entity/lancamento.dart';
import 'package:fluttertest/widgets/lista_lancamento.dart';
import 'package:fluttertest/widgets/new_lancamento.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

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
    Categoria(id: 3, nome: 'cosméticos'),
    Categoria(id: 1, nome: 'automóveis'),
    Categoria(id: 2, nome: 'jogos'),
    Categoria(id: 3, nome: 'cosméticos'),
    Categoria(id: 1, nome: 'automóveis'),
    Categoria(id: 2, nome: 'jogos'),
    Categoria(id: 3, nome: 'cosméticos'),
    Categoria(id: 1, nome: 'automóveis'),
    Categoria(id: 2, nome: 'jogos'),
    Categoria(id: 3, nome: 'cosméticos'),
    Categoria(id: 1, nome: 'automóveis'),
    Categoria(id: 2, nome: 'jogos'),
    Categoria(id: 3, nome: 'cosméticos'),
    Categoria(id: 1, nome: 'automóveis'),
    Categoria(id: 2, nome: 'jogos'),
    Categoria(id: 3, nome: 'cosméticos'),
    Categoria(id: 1, nome: 'automóveis'),
    Categoria(id: 2, nome: 'jogos'),
    Categoria(id: 3, nome: 'cosméticos'),
    Categoria(id: 1, nome: 'automóveis'),
    Categoria(id: 2, nome: 'jogos'),
    Categoria(id: 3, nome: 'cosméticos'),
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

  double totalizador = 0;

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
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Container(
                color: Colors.black38,
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.4,
                child: (Card(
                    child: SingleChildScrollView(
                  padding: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _listaCategorias.map((e) {
                      return Text(e.nome);
                    }).toList(),
                  ),
                ))),
              ),
              Text('data')
            ],
          ),
          ListaLancamentos(_listaLancamentos),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 13, 83, 140),
        hoverColor: const Color.fromARGB(255, 5, 59, 103),
        onPressed: () => _startAddLancamento(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
