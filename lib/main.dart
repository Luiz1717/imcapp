import 'package:flutter/material.dart';

void main() => runApp(const IMCApp());

class IMCApp extends StatelessWidget {
  const IMCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const IMCCalculator(),
    );
  }
}

class IMCCalculator extends StatefulWidget {
  const IMCCalculator({super.key});

  @override
  IMCCalculatorState createState() => IMCCalculatorState();
}

class IMCCalculatorState extends State<IMCCalculator> {
  final _formKey = GlobalKey<FormState>();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  String _resultado = '';

  final List<String> results = [
    "AGUARDANDO DADOS",
    "MAGREZA",
    "NORMAL",
    "SOBREPESO",
    "OBESIDADE",
    "OBESIDADE GRAVE",
  ];

  void _calcularIMC() {
    final peso = double.tryParse(_pesoController.text);
    final altura = double.tryParse(_alturaController.text);

    if (peso != null && altura != null && altura > 0) {
      final imc = peso / (altura * altura);
      print('passou aqui');

      String classificacao;

      if (imc < 18.5) {
        classificacao = results[1];
      } else if (imc < 24.9) {
        classificacao = results[2];
      } else if (imc < 29.9) {
        classificacao = results[3];
      } else if (imc < 34.9) {
        classificacao = results[4];
      } else {
        classificacao = results[5];
      }

      setState(() {
        _resultado = 'Seu IMC é ${imc.toStringAsFixed(2)}\nClassificação: $classificacao';
      });
    } else {
      setState(() {
        _resultado = 'Informe dados válidos!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de IMC')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text(
                  'CALCULADORA DA IMC',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _pesoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Peso (kg)'),
              ),
              TextFormField(
                controller: _alturaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Altura (m)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calcularIMC,
                child: const Text('Calcular'),
              ),
              const SizedBox(height: 20),
              Text(
                _resultado,
                style: const TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
