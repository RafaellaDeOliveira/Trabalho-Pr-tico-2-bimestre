import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import '../model/Produtos.dart';
import '../provider/ProdutosProvider.dart';

class AlteraProdutos extends StatefulWidget {
  late final Produtos produtos;

  AlteraProdutos(this.produtos);
  @override
  _AlteraProdutosState createState() => _AlteraProdutosState();
}

class _AlteraProdutosState extends State<AlteraProdutos> {
  //campos que controlam os textos
  TextEditingController nomeController = TextEditingController();
  TextEditingController localController = TextEditingController();
  TextEditingController comentariosController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nomeController.text = widget.produtos.nome;
    localController.text = widget.produtos.local;
    comentariosController.text = widget.produtos.comentarios;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text(
              "Nome do produto:",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: nomeController,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "Local onde encontrar:",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: localController,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "Comentários:",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              maxLines: null,
              minLines: 3,
              controller: comentariosController,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            ButtonTheme(
              child: ElevatedButton(
                onPressed: _atualizar,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Atualizar",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              buttonColor: Colors.grey.shade300,
            )
          ],
        ),
      ),
    );
  }

  void _atualizar() async {
    ProdutosProvider produtos = ProdutosProvider();
    Map<String, dynamic> linha = {
      ProdutosProvider.columnId: widget.produtos.id,
      ProdutosProvider.columnNome: nomeController.text,
      ProdutosProvider.columnLocal: localController.text,
      ProdutosProvider.columnComentarios: comentariosController.text,
    };
    await produtos.update(linha);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Listagem(),
      ),
    );
  }
}
