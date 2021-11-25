import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import '../provider/ProdutosProvider.dart';

class NovoProduto extends StatefulWidget {
  @override
  _NovoProdutoState createState() => _NovoProdutoState();
}

class _NovoProdutoState extends State<NovoProduto> {
  //campos que controlam os textos
  TextEditingController nomeController = TextEditingController();
  TextEditingController localController = TextEditingController();
  TextEditingController comentariosController = TextEditingController();

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
              "Local onde ser encontrado:",
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
                onPressed: _inserir,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Salvar",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              buttonColor: Colors.grey.shade300,
            ),
            ButtonTheme(
              child: ElevatedButton(
                onPressed: _VoltarTelaInicio,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Inicio",
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

  void _inserir() async {
    ProdutosProvider produtos = ProdutosProvider();
    Map<String, dynamic> linha = {
      ProdutosProvider.columnNome: nomeController.text,
      ProdutosProvider.columnLocal: localController.text,
      ProdutosProvider.columnComentarios: comentariosController.text,
    };
    await produtos.insert(linha);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Principal(),
      ),
    );
  }

  void _VoltarTelaInicio() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Principal(),
      ),
    );
  }
}
