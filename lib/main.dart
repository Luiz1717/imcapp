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

  void _calcularIMC() {
    final peso = double.tryParse(_pesoController.text);
    final altura = double.tryParse(_alturaController.text);

    if (peso != null && altura != null && altura > 0) {
      final imc = peso / (altura * altura);
      setState(() {
        _resultado = 'Seu IMC é ${imc.toStringAsFixed(2)}';
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
            children: [
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
              Text(_resultado, style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
