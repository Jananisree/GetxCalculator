import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'CalculatorController.dart';

class CalculatorApp extends StatelessWidget {
  final CalculatorController controller = Get.put(CalculatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(child: const Text('Calculator',style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 8,fontSize: 25),)),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerRight,
              child: Obx(() {
                return Text(
                  controller.display.value,
                  style: const TextStyle(fontSize: 36),
                  textAlign: TextAlign.right,
                );
              }),
            ),
          ),
          buildButtonRow(['C', '⌫', '÷', '×']),
          buildButtonRow(['7', '8', '9', '-']),
          buildButtonRow(['4', '5', '6', '+']),
          buildButtonRow(['1', '2', '3', '=']),
          buildButtonRow(['0', '.', '(', ')']),
        ],
      ),
    );
  }

  Widget buildButtonRow(List<String> labels) {
    return Row(
      children: labels.map((label) => buildButton(label)).toList(),
    );
  }

  Widget buildButton(String label) {
    final CalculatorController controller = Get.find();

    const Color specialColor = Colors.blueGrey;
    const Color whiteColor = Colors.white;

    bool isTopRow = ['C', '⌫', '÷', '×'].contains(label);
    bool isLastColumn = ['-', '+', '='].contains(label);

    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isTopRow || isLastColumn
                ? specialColor
                : whiteColor,
            foregroundColor: isTopRow || isLastColumn
                ? Colors.white
                : Colors.black, // Text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            if (label == 'C') {
              controller.clearAll();
            } else if (label == '⌫') {
              controller.backspace();
            } else if (label == '=') {
              controller.calculate();
            } else {
              controller.input(label);
            }
          },
          child: Text(
            label,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
