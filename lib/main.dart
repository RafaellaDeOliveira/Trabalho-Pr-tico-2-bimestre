import 'package:prova2/model/Produtos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider/ProdutosProvider.dart';
import 'model/Produtos.dart';
import 'view/AlteraProdutos.dart';
import 'view/MenuLateral.dart';

void main() async {
  runApp(Principal());
}

class Principal extends StatelessWidget {
  final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _notifier,
      builder: (_, mode, __) {
        return MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: mode, // Decides which theme to show, light or dark.
          home: Scaffold(
            body: Center(child: Listagem()),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _notifier.value =
                  mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
              child: new IconTheme(
                data: new IconThemeData(color: Colors.yellow),
                child: new Icon(Icons.wb_twighlight),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Listagem extends StatefulWidget {
  @override
  _ListagemState createState() => _ListagemState();
}

class _ListagemState extends State<Listagem> {
  var listaCompras = []; //vai ler o select all do BD

  late List<Map<String, dynamic>> temp;
  ProdutosProvider produtos = new ProdutosProvider();

  @override
  void initState() {
    super.initState();
    _carregaDados();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  // carrega dados na tela inicial
  void _carregaDados() async {
    temp = await produtos.selectAll();
    temp.forEach((element) {
      Produtos p = new Produtos.fromJson(element);
      setState(() {
        listaCompras.add(p);
      });
    });
  }

  // arrasta pra remover
  void _remover(int index, int produtoId) async {
    temp = await produtos.selectAll();

    setState(() {
      listaCompras.removeAt(index); // remove da tela
      produtos.delete(produtoId); // remove do banco
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.vertical_split),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MenuLateral()));
          },
        ),
        centerTitle: true,
        title: Text("Lista de compras"),
      ),
      body: SafeArea(
        child: listaCompras.length > 0
            ? ListView.builder(
                itemCount: listaCompras.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  final produtos = listaCompras[index];
                  return Dismissible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            produtos.nome,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text("Local: ${produtos.local}"),
                        ],
                      ),
                    ),
                    key: Key(produtos.id.toString()),
                    background: _direitaBackground(), //arrasta para direita
                    secondaryBackground:
                        _esquerdaBackground(), //arrasta pra esquerda
                    confirmDismiss: (DismissDirection direcao) async {
                      if (direcao == DismissDirection.startToEnd) {
                        //da esquerda para direita
                        //abre tela para update
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlteraProdutos(produtos),
                          ),
                        );
                      } else {
                        //da direita para esquerda
                        int id = produtos.id;
                        _remover(index, id);
                        return true;
                        // deleta o item
                      }
                    },
                  );
                },
              )
            : Center(child: Text("Nenhum produto cadastrado")),
      ),
    );
  }
}

//background da Esquerda
Widget _esquerdaBackground() {
  return Container(
    color: Colors.red,
    child: Align(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              "Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    ),
    alignment: Alignment.centerLeft,
  );
}

//background da Direita
Widget _direitaBackground() {
  return Container(
    color: Colors.green,
    child: Align(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Alterar",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            )
          ],
        ),
      ),
    ),
    alignment: Alignment.centerLeft,
  );
}
