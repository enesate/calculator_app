import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget numButton(String btnText, Color btnColor, Color txtColor) {
    return ElevatedButton(
      onPressed: () {
        calculate(btnText);
      },
      child: Text(
        btnText,
        style: TextStyle(
          fontSize: 21,
          color: txtColor,
        ),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(70, 70),
        shape: CircleBorder(),
        backgroundColor: btnColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Calculator"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    alignment: Alignment.centerLeft ,
                    child: Text(
                      equation,
                      //textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      result,
                      //textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numButton("C", Colors.grey, Colors.black),
                numButton("DEL", Colors.grey, Colors.black),
                numButton("%", Colors.grey, Colors.black),
                numButton("/", Colors.orange, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numButton("7", (Colors.grey[850])!, Colors.white),
                numButton("8", (Colors.grey[850])!, Colors.white),
                numButton("9", (Colors.grey[850])!, Colors.white),
                numButton("x", Colors.orange, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numButton("4", (Colors.grey[850])!, Colors.white),
                numButton("5", (Colors.grey[850])!, Colors.white),
                numButton("6", (Colors.grey[850])!, Colors.white),
                numButton("-", Colors.orange, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numButton("1", (Colors.grey[850])!, Colors.white),
                numButton("2", (Colors.grey[850])!, Colors.white),
                numButton("3", (Colors.grey[850])!, Colors.white),
                numButton("+", Colors.orange, Colors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    calculate('0');
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(28, 12, 90, 12),
                    child: Text(
                      "0",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    primary: (Colors.grey[850])!,
                  ),
                ),
                numButton(".", (Colors.grey[850])!, Colors.white),
                numButton("=", Colors.orange, Colors.white),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  String equation = "";
  String result = "0";
  String expression = "";
  //double equationFontSize = 38.0;
  //double resultFontSize = 48.0;

  calculate(String btnText){
    setState(() {
      if(btnText == '%'){
        result = ((int.parse(equation))/ 100).toString();
      }
      if (btnText == "C"){
        equation = "";
        result = "0";
        //double equationFontSize = 38.0;
        //double resultFontSize = 48.0;

      }else if (btnText == "DEL"){
        //double equationFontSize = 48.0;
        //double resultFontSize = 38.0;
        equation = equation.substring(0,equation.length - 1);

        if (equation == ""){
          equation = "";
        }
      }else if (btnText == "=" || btnText == ''){
        //double equationFontSize = 38.0;
        //double resultFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll('x','*');
        expression = expression.replaceAll('/', '/');

        try{

          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL,cm)}';

        }catch(e){
          result = "Error";
        }
      }else {
        //equationFontSize = 48.0;
        //resultFontSize = 38.0;
        /*if (equation == "0"){
          equation = btnText;
        }*/
        equation = equation + btnText;
      }
    });

  }
// Logic
/*dynamic  firstNumber = 0;
  dynamic secondNumber = 0;
  dynamic result = '';
  dynamic text = "";
  dynamic operation = "";
  dynamic question = '';
  void calculate(String btnText) {
    if (btnText == "C") {
      result = "";
      text = "";
      firstNumber = 0;
      secondNumber = 0;
      question = "";
      btnText = '';
    }
    else if (btnText == "+" ||
        btnText == "-" ||
        btnText == "x" ||
        btnText == "/" ||
        btnText == "%" ||
        btnText == "+/-" ||
        btnText == '.') {
      firstNumber = int.parse(text);

      //question = result;
      result = '';
      operation = btnText;
      //question += btnText;
      if (btnText == "+/-" ){
        if(firstNumber > 0)
          result = '-' + text;
        else
          result = '+' + text;
      }
    }
    else if (btnText == "=") {
      secondNumber = int.parse(text);
      if (operation == "+") {
        result = (firstNumber + secondNumber).toString();
      }
      if (operation == "-") {
        result = (firstNumber - secondNumber).toString();
      }
      if (operation == "x") {
        result = (firstNumber * secondNumber).toString();
      }
      if (operation == "/") {
        result = (firstNumber ~/ secondNumber).toString();
      }
      if (operation == "%") {
        result = ((firstNumber * secondNumber)/ 100).toString();
      }

    }

    else {
      result = int.parse(text + btnText).toString();
    }
    setState(() {
      //text = question;
      //question = result;
      text = result;
      if (btnText != 'C' || btnText != '+/-'){
          question += btnText;
      }
    });
  }*/
}