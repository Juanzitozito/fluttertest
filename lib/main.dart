import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/boxes.dart';
import 'package:fluttertest/entity/categoria.dart';
import 'package:fluttertest/entity/lancamento.dart';
import 'package:fluttertest/entity/orcamento.dart';
import 'package:fluttertest/widgets/lista_lancamento.dart';
import 'package:fluttertest/widgets/nav_bar.dart';
import 'package:fluttertest/widgets/new_lancamento.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:month_year_picker/month_year_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(CategoriaAdapter());
  Hive.registerAdapter(LancamentoAdapter());
  Hive.registerAdapter(OrcamentoAdapter());

  // ignore: unused_local_variable
  var categoriasBox = await Hive.openBox<Categoria>('categorias');
  // ignore: unused_local_variable
  var lancamentosBox = await Hive.openBox<Lancamento>('lancamentos');
  // ignore: unused_local_variable
  var orcamentosBox = await Hive.openBox<Orcamento>('orcamentos');

  return runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

var categorias = Hive.box<Categoria>('categorias').values.toList();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenses',
      home: MyHomePage(),
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
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

  DateTimeRange? _selectedDate;
  String? _stringObservacao;
  String? _valueDropdown;

  void _show() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'Done',
    );

    if (result != null) {
      setState(() {
        _selectedDate = result;
      });
    } else {
      setState(() {});
    }
  }

  void addOrcamento(
    String nomeCat,
    double valor,
    DateTime data,
  ) {
    final box = Boxes.getOrcamentos();

    final newOrc = Orcamento(
        id: Random().nextInt(999999999),
        categoria: nomeCat,
        valorPrevisao: valor,
        dataPrevisao: data);

    box.add(newOrc);
  }

  void _observacaoFilter(String valor) {
    setState(() {
      _stringObservacao = valor;
    });
  }

  void _clearFilter() {
    _selectedDate = null;
    setState(() {});
  }

  void _clearCategoriaFilter() {
    _valueDropdown = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(addOrcamento),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return Container(
                        padding: const EdgeInsets.only(bottom: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: _show,
                                    child: const Text('data'),
                                  ),
                                  IconButton(
                                    tooltip: (_selectedDate == null)
                                        ? 'filtro não está ativo'
                                        : 'limpar filtro',
                                    onPressed: _clearFilter,
                                    icon: Icon(Icons.cancel_outlined,
                                        color: (_selectedDate == null)
                                            ? Colors.black54
                                            : Colors.red),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextField(
                                decoration:
                                    const InputDecoration(labelText: 'nome'),
                                onChanged: _observacaoFilter,
                              ),
                            ),
                            SizedBox(
                              child: Row(
                                children: [
                                  DropdownButton(
                                    value: _valueDropdown,
                                    items: categorias.map((e) {
                                      return DropdownMenuItem(
                                        value: e.nome,
                                        child: Text(e.nome),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _valueDropdown = value;
                                      });
                                    },
                                  ),
                                  IconButton(
                                    tooltip: (_valueDropdown == null)
                                        ? 'filtro não está ativo'
                                        : 'limpar filtro',
                                    onPressed: _clearCategoriaFilter,
                                    icon: Icon(Icons.cancel_outlined,
                                        color: (_valueDropdown == null)
                                            ? Colors.black54
                                            : Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              icon: const Icon(Icons.search))
        ],
        title: const Text('My expenses app'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ValueListenableBuilder<Box<Lancamento>>(
              valueListenable: Boxes.getLancamentos().listenable(),
              builder: (content, box, _) {
                var lancamentos = box.values.toList().cast<Lancamento>();
                var observacao = _stringObservacao ?? '';
                var data = _selectedDate ??
                    DateTimeRange(start: DateTime.now(), end: DateTime.now());
                var categoria = _valueDropdown ?? '';

                lancamentos = box.values
                    .toList()
                    .cast<Lancamento>()
                    .where((e) {
                      return (_selectedDate != null)
                          ? e.emissao.isAfter(data.start) &&
                              e.emissao.isBefore(data.end)
                          : e.emissao.difference(data.end).inDays <= 10;
                    })
                    .where((e) => e.observacao
                        .toLowerCase()
                        .contains(observacao.toLowerCase()))
                    .where((e) => e.categoria
                        .toLowerCase()
                        .contains(categoria.toLowerCase()))
                    .toList();

                return ListaLancamentos(
                    lancamentos, _deleteLancamento, _startEditLancamento);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddLancamento(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
