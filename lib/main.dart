import 'package:flutter/material.dart';
import 'package:fluttertest/entity/categoria.dart';

void main(List<String> args) {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Categoria> _listaCategorias = [
    Categoria(id: 1, nome: 'carro'),
    Categoria(id: 2, nome: 'jogos'),
    Categoria(id: 3, nome: 'cosméticos')
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My expenses app'),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.black38,
              width: double.infinity,
              child: (Card(
                child: Row(
                  children: [
                    Column(
                      children: [Text('a'), Text('a'), Text('a')],
                    ),
                    Column(
                      children: [Text('a'), Text('a'), Text('a')],
                    )
                  ],
                ),
              )),
            ),
            Column(
              children: _listaCategorias.map((e) {
                return Card(
                  elevation: 7.0,
                  child: Text(e.nome),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
