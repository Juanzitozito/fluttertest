import 'package:flutter/material.dart';
import 'package:fluttertest/entity/categoria.dart';
import 'package:fluttertest/entity/lancamento.dart';

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

class MyHomePage extends StatelessWidget {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _listaLancamentos.map((e) {
              return Card(
                elevation: 7.0,
                child: Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              color: Colors.blue,
                              width: 3,
                            )),
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(7),
                        child: Text(
                          'R\$ ${e.valor.toString()}',
                          style: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w700),
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.observacao,
                          style: const TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w600),
                        ),
                        Text(e.emissao.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400))
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
