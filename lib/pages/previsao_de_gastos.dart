import 'package:flutter/material.dart';
import 'package:fluttertest/entity/categoria.dart';

class PrevisaoDeGastos extends StatefulWidget {
  PrevisaoDeGastos({super.key});

  @override
  State<PrevisaoDeGastos> createState() => _PrevisaoDeGastosState();
}

class _PrevisaoDeGastosState extends State<PrevisaoDeGastos> {
  final cucu = TextEditingController();

  String? _value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('registro de previsões'),
      ),
      body: Card(
        child: Row(
          children: [
            SizedBox(
              height: 150,
              width: 500,
              child: Column(
                children: [
                  TextField(
                    controller: cucu,
                  ),
                  DropdownButton(
                      value: _value,
                      items: const [
                        DropdownMenuItem(
                          value: 'a',
                          child: Text('a'),
                        )
                      ],
                      onChanged: (v) {
                        print(v);
                        setState(() {
                          _value = v;
                        });
                      }),
                  ElevatedButton(
                      onPressed: () {
                        print('fvck');
                      },
                      child: Text('estabelecer previsão'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
