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
    ProviderScope(
      child: MyApp(),
    ),
  );
}

final listaDeCategorias = Provider<List<Categoria>>((ref) {
  return [
    Categoria(id: 1, nome: 'automóveis'),
    Categoria(id: 2, nome: 'jogos'),
    Categoria(id: 3, nome: 'cosméticos'),
  ];
});

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
  /* final List<Lancamento> _listaLancamentos = [
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
  ]; */

  void _addNewLancamento(
      String observacao, double valor, String categoria, String emissao) {
    final newLanc = Lancamento(
        emissao: DateTime.parse(emissao),
        valor: valor,
        observacao: observacao,
        categoria: categoria,
        id: UniqueKey().hashCode);

    final box = Boxes.getLancamentos();
    box.add(newLanc);
  }

  void _startAddLancamento(BuildContext ctx) {
    final opcoesCategoria = Boxes.getCategorias().values;

    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewLancamento(_addNewLancamento, opcoesCategoria);
        });
  }

  void _deleteLancamento(Lancamento lancamento) {
    lancamento.delete();
  }

  void _editLancamento(Lancamento lancamento, String observacao, double valor,
      String categoria, String emissao) {
    lancamento.observacao = observacao;
    lancamento.valor = valor;
    lancamento.categoria = categoria;
    lancamento.emissao = DateTime.parse(emissao);

    lancamento.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: const Text('My expenses app'),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: ValueListenableBuilder<Box<Lancamento>>(
              valueListenable: Boxes.getLancamentos().listenable(),
              builder: (content, box, _) {
                final lancamentos = box.values.toList().cast<Lancamento>();

                return ListaLancamentos(
                    lancamentos, _deleteLancamento, _editLancamento);
              },
            ),
          ),
        ],
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
