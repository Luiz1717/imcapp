import 'package:flutter_test/flutter_test.dart';

double calcularIMC(double peso, double altura) {
  return peso / (altura * altura);
}

void main() {
  test('Deve calcular IMC corretamente', () {
    final imc = calcularIMC(70, 1.75);
    expect(imc.toStringAsFixed(2), '22.86');
  });
}
