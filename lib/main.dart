import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ),
);

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _peso = TextEditingController();
  TextEditingController _altura = TextEditingController();
  String _result;

  @override
  void initState() {
    super.initState();
    resetFields();
  }

  void resetFields() {
    _peso.text = '';
    _altura.text = '';
    setState(() {
      _result = 'Informe seus dados';
    });
  }

  void calculateImc() {
    double weight = double.parse(_peso.text);
    double height = double.parse(_altura.text) / 100.0;
    double imc = weight / (height * height);

    setState(() {
      _result = "IMC = ${imc.toStringAsPrecision(3)}\n";
      if (imc < 16.0)
        _result += "Magreza Grau 3";
      else if (imc < 16.9)
        _result += "Magreza Grau 2";
      else if (imc < 18.4)
        _result += "Magreza Grau 1";
      else if (imc < 25)
        _result += "Eutrofia";
      else if (imc < 30)
        _result += "Sobrepeso - Risco de Saúde Aumentado";
      else if (imc < 35.0)
        _result += "Obesidade Grau 1 - Risco de Saúde Moderado";
      else if (imc < 40.0)
        _result += "Obesidade Grau 2 - Risco de Saúde Grave";
      else
        _result += "Obesidade Grau 3 - Risco de Saúde Muito Grave";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0), child: buildForm()));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Calcular IMC'),
      backgroundColor: Colors.blue,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            resetFields();
          },
        )
      ],
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildTextFormField(
              label: "Peso (kg)",
              error: "Insira seu peso!",
              controller: _peso),
          buildTextFormField(
              label: "Altura (cm)",
              error: "Insira uma altura!",
              controller: _altura),
          buildTextResult(),
          buildCalculateButton(),
        ],
      ),
    );
  }

  Padding buildCalculateButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: RaisedButton(
        color:  Colors.blue,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            calculateImc();
          }
        },
        child: Text(
            'CALCULAR',
            style:
            TextStyle(color: Colors.white,
            ),


        ),
      ),
    );
  }

  Padding buildTextResult() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: Text(
        _result,
        textAlign: TextAlign.center,
      ),
    );
  }

  TextFormField buildTextFormField(
      {TextEditingController controller, String error, String label}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (text) {
        return text.isEmpty ? error : null;
      },
    );
  }
}