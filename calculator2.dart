import 'package:flutter/material.dart';

class Calculatorr extends StatefulWidget {
  const Calculatorr({super.key});

  @override
  State<Calculatorr> createState() => _CalculatorrState();
}

class _CalculatorrState extends State<Calculatorr> {
  String displayText = "0";
  String firstOperand = "";
  String secondOperand = "";
  String operation = "";
  bool isResultDisplayed = false;

  void calculation(String buttonText) {
    if (buttonText == "AC") {
      clear();
    } else if (buttonText == "=") {
      if (firstOperand != "" && secondOperand != "") {
        double result = performOperation();
        setState(() {
          displayText = result.toString();
          firstOperand = result.toString();
          secondOperand = "";
          isResultDisplayed = true;
        });
      }
    } else if (buttonText == "+/-") {
      if (displayText != "0") {
        setState(() {
          if (displayText.startsWith("-")) {
            displayText = displayText.substring(1);
          } else {
            displayText = "-" + displayText;
          }
        });
      }
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "x" ||
        buttonText == "/") {
      if (firstOperand != "" && !isResultDisplayed) {
        operation = buttonText;
        setState(() {
          displayText += operation;
        });
      }
    } else {
      if (!isResultDisplayed) {
        if (operation.isEmpty) {
          firstOperand += buttonText;
          setState(() {
            displayText = firstOperand;
          });
        } else {
          secondOperand += buttonText;
          setState(() {
            displayText += buttonText;
          });
        }
      } else {
        clear();
        firstOperand = buttonText;
        setState(() {
          displayText = firstOperand;
          isResultDisplayed = false;
        });
      }
    }
  }

  void clear() {
    setState(() {
      displayText = "0";
      firstOperand = "";
      secondOperand = "";
      operation = "";
      isResultDisplayed = false;
    });
  }

  double performOperation() {
    double first = double.parse(firstOperand);
    double second = double.parse(secondOperand);
    switch (operation) {
      case "+":
        return first + second;
      case "-":
        return first - second;
      case "x":
        return first * second;
      case "/":
        return first / second;
      default:
        return 0.0;
    }
  }

  Widget calcButton(String buttonText, Color bgColor, Color txtColor) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,

          //primary: bgColor,
          // onPrimary: txtColor,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
        ),
        onPressed: () {
          calculation(buttonText);
        },
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 35,
            color: txtColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Calculator App',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    displayText,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('AC', Colors.grey.shade100, Colors.black),
                calcButton('+/-', Colors.grey.shade100, Colors.black),
                calcButton('%', Colors.grey.shade100, Colors.black),
                calcButton('/', Colors.amber, Colors.black),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('7', Colors.grey.shade800, Colors.white),
                calcButton('8', Colors.grey.shade800, Colors.white),
                calcButton('9', Colors.grey.shade800, Colors.white),
                calcButton('x', Colors.amber, Colors.black),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('4', Colors.grey.shade800, Colors.white),
                calcButton('5', Colors.grey.shade800, Colors.white),
                calcButton('6', Colors.grey.shade800, Colors.white),
                calcButton('-', Colors.amber, Colors.black),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('1', Colors.grey.shade800, Colors.white),
                calcButton('2', Colors.grey.shade800, Colors.white),
                calcButton('3', Colors.grey.shade800, Colors.white),
                calcButton('+', Colors.amber, Colors.black),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.fromLTRB(34, 20, 120, 20),
                  ),
                  onPressed: () {
                    calculation('0');
                  },
                  child: const Text(
                    '0',
                    style: TextStyle(fontSize: 35, color: Colors.black),
                  ),
                ),
                calcButton('.', Colors.amber, Colors.black),
                calcButton('=', Colors.amber, Colors.black),
              ],
            )
          ],
        ),
      ),
    );
  }
}
