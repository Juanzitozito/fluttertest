import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/entity/lancamento.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class ListaLancamentos extends StatefulWidget {
  final List<Lancamento> lancamentos;
  final Function deleteLancamentos;
  final Function startEditLancamentos;

  const ListaLancamentos(
      this.lancamentos, this.deleteLancamentos, this.startEditLancamentos,
      {super.key});

  @override
  State<ListaLancamentos> createState() => _ListaLancamentosState();
}

class _ListaLancamentosState extends State<ListaLancamentos> {
  final listaCsv = <List<String>>[];

  csv(listaCSV) async {
    List<List<String>> data = listaCSV;

    String csvData = const ListToCsvConverter().convert(data);
    final String directory = (await getApplicationSupportDirectory()).path;
    final path = "$directory\\csv-juan.csv";
    print(path);
    final File file = File(path);
    await file.writeAsString(csvData);

    return file;
  }

  @override
  Widget build(BuildContext context) {
    listaCsv.add(['data', 'valor', 'observacao', 'categoria']);

    double contador = 0;
    return Column(
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: widget.lancamentos.map((e) {
              contador += e.valor;

              listaCsv.add([
                e.emissao.toString(),
                e.valor.toString(),
                e.observacao,
                e.categoria
              ]);

              return SizedBox(
                width: double.infinity,
                child: Card(
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
                            'R\$ ${e.valor.toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w700),
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.observacao,
                            style: const TextStyle(
                                fontSize: 19, fontWeight: FontWeight.w600),
                          ),
                          Text(
                              '${DateFormat('dd/MM/yyyy H').format(e.emissao)}h',
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400))
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(left: 10),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 31, 133, 217),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Text(
                          e.categoria,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () =>
                                widget.startEditLancamentos(context, e.id),
                            icon: const Icon(Icons.edit),
                            padding: const EdgeInsets.all(10),
                          ),
                          IconButton(
                            onPressed: () => widget.deleteLancamentos(e),
                            icon: const Icon(Icons.delete),
                            padding: const EdgeInsets.all(10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList()),
        Text(
            'Total de ${widget.lancamentos.length} registros, resultando em um total de  R\$${contador.toString()}'),
        IconButton(
            onPressed: (() async {
              await csv(listaCsv);
            }),
            icon: const Icon(Icons.import_export))
      ],
    );
  }
}
