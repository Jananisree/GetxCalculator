import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorController extends GetxController {

  var display = ''.obs;
  var lastResult = ''.obs;
  var isResultShown = false.obs;

  void input(String value) {
    if (isResultShown.value) {
      display.value = lastResult.value;
      isResultShown.value = false;
    }
    display.value += value;
  }

  void calculate() {
    try {
      String finalExpression =
      display.value.replaceAll('×', '*').replaceAll('÷', '/');
      Parser parser = Parser();
      Expression expression = parser.parse(finalExpression);
      ContextModel contextModel = ContextModel();

      num result = expression.evaluate(EvaluationType.REAL, contextModel);

      lastResult.value = (result % 1 == 0)
          ? result.toInt().toString()
          : result.toString();

      display.value = lastResult.value;
      isResultShown.value = true;
    } catch (e) {
      display.value = 'Error';
    }
  }

  void clearAll() {
    display.value = '';
    lastResult.value = '';
    isResultShown.value = false;
  }

  void backspace() {
    if (display.value.isNotEmpty && !isResultShown.value) {
      display.value = display.value.substring(0, display.value.length - 1);
    }
  }
}
