import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const IMCApp());

final themeNotifier = ValueNotifier(ThemeMode.light);

class IMCApp extends StatelessWidget {
  const IMCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, themeMode, child) {
        return MaterialApp(
          title: 'Calculadora de IMC',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeMode,
          home: const IMCCalculator(),
        );
      },
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
  bool _mostrarResultado = false;
  List<String> _historicoIMC = [];

  @override
  void initState() {
    super.initState();
    _carregarHistorico();
  }

  Future<void> _salvarHistorico(String resultado) async {
    final prefs = await SharedPreferences.getInstance();
    _historicoIMC.add(resultado);
    await prefs.setStringList('historico_imc', _historicoIMC);
  }

  Future<void> _carregarHistorico() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _historicoIMC = prefs.getStringList('historico_imc') ?? [];
    });
  }

  void _calcularIMC() {
    final peso = double.tryParse(_pesoController.text);
    final altura = double.tryParse(_alturaController.text);

    if (peso != null && altura != null && altura > 0) {
      final imc = peso / (altura * altura);
      String classificacao = _classificarIMC(imc);
      final resultadoFinal = 'IMC: ${imc.toStringAsFixed(2)} ($classificacao)';

      setState(() {
        _resultado = resultadoFinal;
        _mostrarResultado = true;
      });

      _salvarHistorico(resultadoFinal);
    } else {
      setState(() {
        _resultado = 'Informe dados válidos!';
        _mostrarResultado = true;
      });
    }
  }

  String _classificarIMC(double imc) {
    if (imc < 18.5) return "MAGREZA";
    if (imc < 24.9) return "NORMAL";
    if (imc < 29.9) return "SOBREPESO";
    if (imc < 34.9) return "OBESIDADE";
    return "OBESIDADE GRAVE";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              themeNotifier.value =
              themeNotifier.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'CALCULADORA DE IMC',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: _mostrarResultado ? 1.0 : 0.0,
                  child: Text(
                    _resultado,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                ExpansionTile(
                  title: const Text('Histórico de IMCs'),
                  children: _historicoIMC
                      .map((e) => ListTile(title: Text(e)))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
