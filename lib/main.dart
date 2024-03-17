// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculateScreen(),
    );
  }
}

class CalculateScreen extends StatelessWidget {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculate BMI'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter Height (cm)'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter Weight (kg)'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  double height = double.tryParse(heightController.text) ?? 0.0;
                  double weight = double.tryParse(weightController.text) ?? 0.0;
                  double bmi = weight / ((height / 100) * (height / 100)); // Corrected BMI calculation
                  Get.to(InformationScreen(bmi: bmi));
                },
                child: Text('Calculate BMI'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InformationScreen extends StatelessWidget {
  final double bmi;

  InformationScreen({required this.bmi});

  @override
  Widget build(BuildContext context) {
    String category = _getCategory(bmi);
    String message = _getMessage(category);

    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Information'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your BMI: ${bmi.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Text(
                'Category: $category',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Text(
                'Message: $message',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getCategory(double bmi) {
    if (bmi < 16) {
      return 'Severe undernourishment';
    } else if (bmi >= 16 && bmi < 16.9) {
      return 'Medium undernourishment';
    } else if (bmi >= 17 && bmi < 18.4) {
      return 'Slight undernourishment';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Normal nutrition site';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Overweight';
    } else if (bmi >= 30 && bmi < 39.9) {
      return 'Obesity';
    } else {
      return 'Pathological obesity';
    }
  }

  String _getMessage(String category) {
    switch (category) {
      case 'Severe undernourishment':
        return 'You may need to gain some weight.';
      case 'Medium undernourishment':
        return 'You may need to gain some weight.';
      case 'Slight undernourishment':
        return 'You may need to gain some weight.';
      case 'Normal nutrition site':
        return 'You have a healthy weight!';
      case 'Overweight':
        return 'You may need to lose some weight.';
      case 'Obesity':
        return 'You may need to lose some weight.immediatly';
      case 'Pathological obesity':
        return 'You are at risk. Please consult a doctor.';
      default:
        return '';
    }
  }
}
