import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Pessoa {
  double altura;
  double peso;

  Pessoa({required this.altura, required this.peso});

  double calcularIMC() {
    return peso / (altura * altura);
  }
}

class ListaDeImc {
  List<String> lista = [];

  void adicionarIMC(String imc) {
    lista.add(imc);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 11, 139, 212)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculadora de IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  String resultado = '';
  ListaDeImc listaIMC = ListaDeImc(); // Adicionando uma instância de ListaDeImc

  void calcularIMC() {
    double altura = double.parse(alturaController.text);
    double peso = double.parse(pesoController.text);

    Pessoa pessoa = Pessoa(altura: altura, peso: peso);
    double imc = pessoa.calcularIMC();

    listaIMC.adicionarIMC(imc.toStringAsFixed(2)); // Adicionando o IMC à lista

    setState(() {
      resultado = 'Seu IMC é: ${imc.toStringAsFixed(2)}';
    });
  }

  void salvarResultado() {
    double altura = double.parse(alturaController.text);
    double peso = double.parse(pesoController.text);

    Pessoa pessoa = Pessoa(altura: altura, peso: peso);
    double imc = pessoa.calcularIMC();

    listaIMC.adicionarIMC(imc.toStringAsFixed(2));

    setState(() {
      resultado = 'Seu IMC é: ${imc.toStringAsFixed(2)}';
    });
  }

  void mostraResultadosSalvos() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Resultados Salvos'),
          content: Column(
            children: listaIMC.lista.map((resultado) {
              return Text('Seu Imc é $resultado');
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry padding = EdgeInsets.all(20.0);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: padding,
              child: TextField(
                  controller: alturaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Altura (m)',
                  )),
            ),
            Padding(
              padding: padding,
              child: TextField(
                  controller: pesoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Peso (kg)',
                  )),
            ),
            ElevatedButton(
              onPressed: calcularIMC,
              child: Text('Calcular IMC'),
            ),
            ElevatedButton(
              onPressed: salvarResultado,
              child: Text('Salvar Resultado'),
            ),
            ElevatedButton(
                onPressed: mostraResultadosSalvos,
                child: Text('Mostrar Resultados Salvos')),
            SizedBox(height: 20),
            Text(resultado),
          ],
        ),
      ),
    );
  }
}
