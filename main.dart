/*
Students Names: Abed Alkader Jawhar-Mohammad Mokadem.
Instructor Name:Dr. Bassel Dhaini.
Section: E MW 3:30.
Course: Mobile application CSCI410.
*/
import 'package:flutter/material.dart';

void main() {
  runApp(UnitConverterApp());
}

class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.blue,
        ),
      ),
      home: UnitConverter(),
    );
  }
}

class UnitConverter extends StatefulWidget {
  @override
  _UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  String selectedCategory = 'Length';
  String fromUnit = 'cm';
  String toUnit = 'm';
  String result = '0.0';
  TextEditingController controller = TextEditingController();

  Map<String, Map<String, double>> conversionRates = {
    'Length': {
      'cm': 1,
      'm': 100,
      'km': 100000,
    },
    'Mass': {
      'g': 1,
      'kg': 1000,
      'lb': 453.592,
    },
    'Time': {
      'seconds': 1,
      'minutes': 60,
    },
  };






  //un-done
  void convert() {
    double inputValue = double.tryParse(controller.text) ?? 0;
    double fromRate = conversionRates[selectedCategory]?[fromUnit] ?? 1;
    double toRate = conversionRates[selectedCategory]?[toUnit] ?? 1;
    double convertedValue = (inputValue * fromRate) / toRate;

    setState(() {
      result = convertedValue.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Converter'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [

            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Value',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.blue), // Blue label
              ),
            ),
            SizedBox(height: 20),


            DropdownButton<String>(
              value: selectedCategory,
              onChanged: (category) {
                setState(() {
                  selectedCategory = category!;
                  fromUnit = conversionRates[selectedCategory]!.keys.first;
                  toUnit = conversionRates[selectedCategory]!.keys.first;
                });
              },




              //done
              items: ['Length', 'Mass', 'Time']
                  .map((category) => DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              )).toList(),
            ),
            SizedBox(height: 20),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: fromUnit,
                  onChanged: (unit) {
                    setState(() {
                      fromUnit = unit!;
                    });
                  },
                  items: conversionRates[selectedCategory]!.keys.map((unit) => DropdownMenuItem<String>(
                    value: unit,
                    child: Text(unit),
                  ))
                      .toList(),
                ),
                Text('    to     '),
                DropdownButton<String>(
                  value: toUnit,
                  onChanged: (unit) {
                    setState(() {
                      toUnit = unit!;
                    });
                  },
                  items: conversionRates[selectedCategory]!.keys
                      .map((unit) => DropdownMenuItem<String>(
                    value: unit,
                    child: Text(unit),
                  ))
                      .toList(),
                ),
              ],
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: convert,
              child: Text(' Convert '),
            ),
            SizedBox(height: 20),


            Text(
              'Result: $result $toUnit',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
