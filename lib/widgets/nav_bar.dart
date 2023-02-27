import 'package:flutter/material.dart';
import 'package:fluttertest/pages/categorias.dart';

class NavBar extends StatelessWidget {
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
                  MaterialPageRoute(builder: (context) => Categorias()));
            },
            title: const Text(
              'categorias',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(
              Icons.add_box_outlined,
              color: Colors.blue,
            ),
            title: Text(
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
