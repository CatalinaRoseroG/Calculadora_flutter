import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculadoraScreen(),
    );
  }
}

class CalculadoraScreen extends StatefulWidget {
  @override
  _CalculadoraScreenState createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  String input = "";
  String output = "";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        input = "";
        output = "";
      } else if (buttonText == "=") {
        try {
          // Dividir la entrada en número1, operador y número2
          final partes = input.split(RegExp(r'[-+*/]'));
          if (partes.length == 3) {
            final num1 = double.tryParse(partes[0]);
            final operador = partes[1];
            final num2 = double.tryParse(partes[2]);

            if (num1 != null && num2 != null) {
              double resultado;
              switch (operador) {
                case "+":
                  resultado = sumar(num1, num2);
                  break;
                case "-":
                  resultado = restar(num1, num2);
                  break;
                case "*":
                  resultado = multiplicar(num1, num2);
                  break;
                case "/":
                  resultado = dividir(num1, num2);
                  break;
                default:
                  throw Exception("Operador no válido");
              }

              output = resultado.toString();
            } else {
              throw Exception("Error de formato en los números");
            }
          } else {
            throw Exception("Operación inválida");
          }
        } catch (e) {
          output = " ";
        }
      } else {
        input += buttonText;
      }
    });
  }

  double sumar(double num1, double num2) {
    return num1 + num2;
  }

  double restar(double num1, double num2) {
    return num1 - num2;
  }

  double multiplicar(double num1, double num2) {
    return num1 * num2;
  }

  double dividir(double num1, double num2) {
    if (num2 == 0) {
      throw Exception("División por cero");
    }
    return num1 / num2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora App'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(24.0),
              alignment: Alignment.bottomRight,
              child: Text(
                input,
                style: TextStyle(fontSize: 36.0),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(24.0),
              alignment: Alignment.bottomRight,
              child: Text(
                output,
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              buildButton("7"),
              buildButton("8"),
              buildButton("9"),
              buildButton("/"),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton("4"),
              buildButton("5"),
              buildButton("6"),
              buildButton("*"),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton("1"),
              buildButton("2"),
              buildButton("3"),
              buildButton("-"),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton("0"),
              buildButton("C"),
              buildButton("="),
              buildButton("+"),
            ],
          ),
        ],
      ),
    );
  }

  // Función para construir botones numéricos y de operación.
  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => _buttonPressed(buttonText),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(24.0)),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
