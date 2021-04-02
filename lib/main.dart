import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

  String _medidaInicial;
  String _medidaFinal;
  String resultado = "0";

  int _indexMedInicial;
  int _indexMedFinal;

  final _formulas = [
    [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    [0, 0, 1, 0.0001, 0, 0, 0, 0022, 0.035274],
    [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    [0, 0, 28.3495, 0, 02835, 3.28084, 0, 0.0625, 1],
  ];

  final valueTextFieldController = TextEditingController();

  @override
  void initState() {
    this._indexMedInicial = 0;
    this._indexMedFinal = 1;

    this._medidaInicial = this._medidas[this._indexMedInicial];
    this._medidaFinal = this._medidas[this._indexMedFinal];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(color: Colors.blueGrey, fontSize: 40);
    final ddbStyle = TextStyle(color: Colors.blue[700], fontSize: 15);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Conversor de medidas"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Column(children: [
              //Text(_medidaInicial),
              TextField(
                controller: valueTextFieldController,
                decoration: InputDecoration(
                    hintText: "Valor inicial",
                    contentPadding: EdgeInsets.all(10.0)),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 8,
              ), // SizedBox permite crear espacios en blanco entre elementos
              DropdownButton(
                  isExpanded: false,
                  value: _medidaInicial,
                  items: _medidas.map((m) {
                    return DropdownMenuItem(
                      value: m,
                      child: Text(m, style: ddbStyle),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _medidaInicial = value;
                      print(_medidaInicial);
                      print(_medidas.indexOf(_medidaInicial));
                      _indexMedInicial = _medidas.indexOf(_medidaInicial);
                    });
                  }),
              Icon(Icons.arrow_downward),
              DropdownButton(
                  value: _medidaFinal,
                  items: _medidas.map((m) {
                    return DropdownMenuItem(
                      value: m,
                      child: Text(m, style: ddbStyle),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _medidaFinal = value;
                      print(_medidaFinal);
                      _indexMedFinal = _medidas.indexOf(_medidaFinal);
                    });
                  }),
              SizedBox(
                height: 8,
              ),
              // IconButton(
              //     icon: const Icon(Icons.compare_arrows_sharp), onPressed: null),
              // ElevatedButton(
              //     onPressed: null,
              //     child: Text(
              //       "Convertir",
              //       style: buttonTextStyle,
              //     )),
              ElevatedButton.icon(
                  onPressed: () {
                    try {
                      setState(() {
                        // Obtengo el valor digitador por el usuario
                        final valor =
                            double.parse(valueTextFieldController.text.trim());

                        // Calculo el resultado final.
                        this.resultado = (valor *
                                _formulas[_indexMedInicial][_indexMedFinal])
                            .toString();
                      });

                      // Ocultar teclado
                      FocusScope.of(context).requestFocus(FocusNode());

                      print(
                          "$_indexMedInicial, $_indexMedFinal => ${_formulas[_indexMedInicial][_indexMedFinal]}");

                      // Forma corta de asignar el valor a la variable, ojo resultado es numerico y variabe string
                      // this.resultadoFinal = "${_formulas[_indiceMedidaInicial][_indiceMedidaFinal]}"

                    } catch (e) {
                      print("el dato no es numerico");
                      setState(() {
                        valueTextFieldController.text = "";
                      });
                    }
                  },
                  icon: const Icon(Icons.compare_arrows_sharp),
                  label: Text("Convertir")),
              //Spacer(), // permite enviar los elelentos debajo de el al final de la pantalla.
              Text(
                resultado,
                style: labelStyle,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
