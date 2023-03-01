import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/boxes.dart';
import 'package:fluttertest/entity/categoria.dart';
import 'package:fluttertest/entity/lancamento.dart';
import 'package:fluttertest/widgets/lista_lancamento.dart';
import 'package:fluttertest/widgets/nav_bar.dart';
import 'package:fluttertest/widgets/new_lancamento.dart';
import 'package:hive_flutter/adapters.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(CategoriaAdapter());
  Hive.registerAdapter(LancamentoAdapter());

  var categoriasBox = await Hive.openBox<Categoria>('categorias');
  var lancamentosBox = await Hive.openBox<Lancamento>('lancamentos');

  return runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Expenses',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _addNewLancamento(
      String observacao, double valor, String categoria, String emissao) {
    final newLanc = Lancamento(
        emissao: DateTime.parse(emissao),
        valor: valor,
        observacao: observacao,
        categoria: categoria,
        id: Random().nextInt(999999999));

    final box = Boxes.getLancamentos();
    box.add(newLanc);

    Navigator.pop(context);
  }

  void _startAddLancamento(BuildContext ctx) {
    final opcoesCategoria = Boxes.getCategorias().values.toList();

    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewLancamento(
              addInput: _addNewLancamento, opcoesCategorias: opcoesCategoria);
        });
  }

  void _deleteLancamento(Lancamento lancamento) {
    lancamento.delete();
  }

  void _startEditLancamento(BuildContext ctx, id) {
    final opcoesCategoria = Boxes.getCategorias().values.toList();

    final edit = Hive.box<Lancamento>('lancamentos')
        .values
        .where((e) => e.id == id)
        .toList()
        .cast<Lancamento?>();

    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewLancamento(
              addInput: _editLancamento,
              opcoesCategorias: opcoesCategoria,
              editingElement: edit[0]);
        });
  }

  void _editLancamento(Lancamento lancamento, String observacao, double valor,
      String categoria, String emissao) {
    lancamento.observacao = observacao;
    lancamento.valor = valor;
    lancamento.categoria = categoria;
    lancamento.emissao = DateTime.parse(emissao);

    lancamento.save();
    Navigator.pop(context);
  }

  double contador = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text('My expenses app'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ValueListenableBuilder<Box<Lancamento>>(
              valueListenable: Boxes.getLancamentos().listenable(),
              builder: (content, box, _) {
                final lancamentos = box.values.toList().cast<Lancamento>();

                return ListaLancamentos(
                    lancamentos, _deleteLancamento, _startEditLancamento);
              },
            ),
          ],
        ),
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
