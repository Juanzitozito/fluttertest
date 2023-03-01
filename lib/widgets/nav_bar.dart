import 'package:flutter/material.dart';
import 'package:fluttertest/pages/categorias.dart';
import 'package:fluttertest/pages/consultas.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          const ListTile(
            leading: Icon(
              Icons.add_box_outlined,
              color: Colors.blue,
            ),
            title: Text(
              'lançamentos',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const Divider(),
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
                  MaterialPageRoute(builder: (context) => Consultas()));
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
        ],
      ),
    );
  }
}
