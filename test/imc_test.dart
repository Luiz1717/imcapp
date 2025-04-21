import 'package:flutter_test/flutter_test.dart';

double calcularIMC(double peso, double altura) {
  return peso / (altura * altura);
}

String classificarIMC(double imc) {
  if (imc < 18.5) {
    return "MAGREZA";
  } else if (imc < 24.9) {
    return "NORMAL";
  } else if (imc < 29.9) {
    return "SOBREPESO";
  } else if (imc < 34.9) {
    return "OBESIDADE";
  } else {
    return "OBESIDADE GRAVE";
  }
}

void main() {
  test('Deve calcular IMC corretamente', () {
    final imc = calcularIMC(70, 1.75);
    expect(imc.toStringAsFixed(2), '22.86');
  });

  test('Classificação MAGREZA', () {
    final imc = calcularIMC(50, 1.75);
    final classificacao = classificarIMC(imc);
    expect(classificacao, 'MAGREZA');
  });

  test('Classificação NORMAL', () {
    final imc = calcularIMC(70, 1.75);
    final classificacao = classificarIMC(imc);
    expect(classificacao, 'NORMAL');
  });

  test('Classificação SOBREPESO', () {
    final imc = calcularIMC(85, 1.75);
    final classificacao = classificarIMC(imc);
    expect(classificacao, 'SOBREPESO');
  });

  test('Classificação OBESIDADE', () {
    final imc = calcularIMC(105, 1.75);
    final classificacao = classificarIMC(imc);
    expect(classificacao, 'OBESIDADE');
  });

  test('Classificação OBESIDADE GRAVE', () {
    final imc = calcularIMC(120, 1.75);
    final classificacao = classificarIMC(imc);
    expect(classificacao, 'OBESIDADE GRAVE');
  });
}
