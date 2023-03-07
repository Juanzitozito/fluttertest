import 'package:flutter/material.dart';
import 'package:fluttertest/entity/categoria.dart';
import 'package:hive_flutter/adapters.dart';

class PrevisaoDeGastos extends StatefulWidget {
  const PrevisaoDeGastos({super.key});

  @override
  State<PrevisaoDeGastos> createState() => _PrevisaoDeGastosState();
}

class _PrevisaoDeGastosState extends State<PrevisaoDeGastos> {
  final cucu = TextEditingController();

  String? _value;
  var box = Hive.box<Categoria>('categorias');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('registro de previsões'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Card(
                elevation: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // When those voices deep within,
                    // bring you down to your knees again,
                    // redemption calls onto,
                    // all of those who persist with the strength of the few.
                    // Don't come to question all that you've known,
                    // remember you are not alone,
                    // I will be here,
                    // standing beside you.
                    // There is no mountain too tall to overcome,
                    // we will be as one,
                    // you will rise again,
                    // this is your legacy.
                    SizedBox(
                      width: 200,
                      height: 100,
                      child: TextField(
                        decoration: const InputDecoration(
                            labelText: 'valor estipulado'),
                        controller: cucu,
                      ),
                    ),
                    DropdownButton(
                        value: _value,
                        items: box.values
                            .map((e) => DropdownMenuItem(
                                  value: e.nome,
                                  child: Text(e.nome),
                                ))
                            .toList(),
                        onChanged: (v) {
                          setState(() {
                            _value = v;
                          });
                        }),
                    ElevatedButton(
                        onPressed: () {},
                        child: const Text('Definir orçamento'))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
