import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final List<String> _medidas = [
    'metros',
    'kilometros',
    'gramos',
    'kilogramos',
    'pies',
    'millas',
    'libras',
    'onzas',
  ];

  @override
  Widget build(BuildContext context) {
    var _medidaInicial = _medidas[0];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Conversor de medidas"),
        ),
        body: Container(
          child: Column(children: [
            Text(_medidaInicial),
            TextField(
              onChanged: (value) {
                print(value);
              },
            ),
            DropdownButton(
                value: _medidaInicial,
                items: _medidas.map((m) {
                  return DropdownMenuItem(
                    value: m,
                    child: Text(m),
                  );
                }).toList(),
                onChanged: (value) {
                  print(value);
                  _medidaInicial = value;
                })
          ]),
        ),
      ),
    );
  }
}
