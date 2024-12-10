import 'package:flutter/material.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _output = "0";
  String _currentInput = "";
  double? firstNumber;
  double? secondNumber;
  String? operator;

  void _buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _currentInput = "";
        firstNumber = null;
        secondNumber = null;
        operator = null;
      } else if (value == "<-") {
        if (_currentInput.isNotEmpty) {
          _currentInput = _currentInput.substring(0, _currentInput.length - 1);
          _output = _currentInput.isNotEmpty ? _currentInput : "0";
        }
      } else if (value == "+" || value == "-" || value == "*" || value == "/") {
        if (_currentInput.isNotEmpty) {
          firstNumber = double.parse(_currentInput);
          operator = value;
          _currentInput = "";
          _output = "";
        }
      } else if (value == "=") {
        if (_currentInput.isNotEmpty &&
            operator != null &&
            firstNumber != null) {
          secondNumber = double.parse(_currentInput);

          switch (operator) {
            case "+":
              _output = (firstNumber! + secondNumber!).toString();
              break;
            case "-":
              _output = (firstNumber! - secondNumber!).toString();
              break;
            case "*":
              _output = (firstNumber! * secondNumber!).toString();
              break;
            case "/":
              _output = secondNumber != 0
                  ? (firstNumber! / secondNumber!).toString()
                  : "Error";
              break;
          }

          firstNumber = null;
          secondNumber = null;
          operator = null;
          _currentInput = "";
        }
      } else {
        if (_currentInput == "0" && value != ".") {
          _currentInput = value;
        } else {
          _currentInput += value;
        }
        _output = _currentInput;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> buttons = [
      "C",
      "*",
      "/",
      "<-",
      "1",
      "2",
      "9",
      "+",
      "4",
      "5",
      "6",
      "-",
      "7",
      "8",
      "9",
      "*",
      "%",
      "0",
      ".",
      "=",
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Calculator App",
          style: TextStyle(color: Colors.green),
        ),
      ),
      body: Column(
        children: [
          // Input/Output Display
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
              controller: TextEditingController(text: _output),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: buttons.length,
              itemBuilder: (BuildContext context, int index) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20.0),
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    _buttonPressed(buttons[index]);
                  },
                  child: Text(
                    buttons[index],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
