import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorController extends GetxController {
  var expression = ''.obs;
  var result = ''.obs;
  var isResultShown = false.obs;

  void input(String value) {
    if (isResultShown.value) {
      expression.value = '';
      isResultShown.value = false;
    }

    if (_isOperator(value) && expression.value.isNotEmpty && _isOperator(expression.value[expression.value.length - 1])) {
      expression.value = expression.value.substring(0, expression.value.length - 1) + value;
    } else {
      expression.value += value;
    }
  }

  bool _isOperator(String char) {
    return ['+', '-', '×', '÷', '%'].contains(char);
  }

  void calculate() {
    try {
      String finalExpression = expression.value
          .replaceAll('×', '*')
          .replaceAll('÷', '/');

      finalExpression = finalExpression.replaceAllMapped(
        RegExp(r'(\d+)%'),
            (match) => '(${match[1]} * 0.01)',
      );

      Parser parser = Parser();
      Expression exp = parser.parse(finalExpression);
      ContextModel contextModel = ContextModel();

      num evalResult = exp.evaluate(EvaluationType.REAL, contextModel);

      result.value = (evalResult % 1 == 0)
          ? evalResult.toInt().toString()
          : evalResult.toStringAsFixed(6);

      isResultShown.value = true;
    } catch (e) {
      result.value = 'Error';
    }
  }

  void clearAll() {
    expression.value = '';
    result.value = '';
    isResultShown.value = false;
  }

  void backspace() {
    if (expression.value.isNotEmpty && !isResultShown.value) {
      expression.value = expression.value.substring(0, expression.value.length - 1);
    }
  }
}
