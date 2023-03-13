import 'package:flutter/material.dart';
import 'package:fluttertest/pages/categorias.dart';
import 'package:fluttertest/pages/consultas.dart';
import 'package:fluttertest/pages/previsao_de_gastos.dart';

import '../pages/consultas_orcamento.dart';

class NavBar extends StatelessWidget {
  final Function addOrcamento;

  const NavBar(this.addOrcamento, {super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          ListTile(
            leading: const Icon(
              Icons.add_box_outlined,
              color: Colors.blue,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Categorias()));
            },
            title: const Text(
              'categorias',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Consultas()));
            },
            leading: const Icon(
              Icons.add_box_outlined,
              color: Colors.blue,
            ),
            title: const Text(
              'Consultas',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PrevisaoDeGastos(addOrcamento)));
            },
            leading: const Icon(
              Icons.add_box_outlined,
              color: Colors.blue,
            ),
            title: const Text(
              'Orçamento',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConsultasOrcamento()));
            },
            leading: const Icon(
              Icons.add_box_outlined,
              color: Colors.blue,
            ),
            title: const Text(
              'Consultas Orçamento',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
