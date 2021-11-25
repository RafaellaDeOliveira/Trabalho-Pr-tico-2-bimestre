import 'package:flutter/material.dart';

import '../main.dart';
import 'NovoProduto.dart';

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey,
        child: ListView(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).padding.vertical),
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text(
                'Início',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              onTap: () => {
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Listagem(),
                  ),
                )
              },
            ),
            ListTile(
              leading: Icon(
                Icons.plus_one,
                color: Colors.white,
              ),
              title: Text(
                'Novo Produto',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NovoProduto(),
                  ),
                )
              },
            ),
          ],
        ),
      ),
    );
  }
}
