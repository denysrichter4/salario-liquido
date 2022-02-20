import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salario_liquido/domain/controller.dart';

class SalarioView extends StatefulWidget {
  const SalarioView({Key? key}) : super(key: key);

  @override
  _SalarioViewState createState() => _SalarioViewState();
}

class _SalarioViewState extends State<SalarioView> {

  TextEditingController _textEditingControllerSalarioBruto = TextEditingController();
  TextEditingController _textEditingControllerOutros = TextEditingController();
  TextEditingController _textEditingControllerDependentes = TextEditingController();
  Controller controller = Controller();
  var _outros = "";
  var _inss = "";
  var _irrf = "";
  var _total = "";
  var _liquido = "";

  void _calculate(String salarioBruto, String outrosDescontos, String dependentes){
    setState(() {
      if(salarioBruto.isEmpty || outrosDescontos.isEmpty){
        _outros = "";
        _inss = "";
        _irrf = "";
        _total = "";
        _liquido = "";
      }
      else{
        _outros = "$outrosDescontos Reais";
        _inss = "${controller.calculateInss(_toDouble(salarioBruto))} Reais";
        _irrf = "${controller.calculateIrrf(_toDouble(salarioBruto), _toDouble(dependentes))} Reais";
        _total = "${controller.total(_toDouble(salarioBruto), _toDouble(outrosDescontos), _toDouble(dependentes))} Reais";
        _liquido =  "${controller.liquido(_toDouble(salarioBruto), _toDouble(outrosDescontos), _toDouble(dependentes))} Reais";

      }
    });
  }

  void _limpar(){
    setState(() {
      _outros = "";
      _inss = "";
      _irrf = "";
      _total = "";
      _liquido = "";
    });
  }

  double _toDouble(String value){
    return double.parse(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Salário Líquido",
        ),
        backgroundColor: Colors.grey,
      ),
      body: ListView(
        children: [
          Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  border: Border.all(width: 3,color: Colors.black)
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Insira os valores para cálculo:",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: TextField(
                        textAlign: TextAlign.start,
                        controller: _textEditingControllerSalarioBruto,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Salário Bruto",
                        ),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: TextField(
                        textAlign: TextAlign.start,
                        controller: _textEditingControllerOutros,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Outros gastos não tributáveis",
                        ),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: TextField(
                        textAlign: TextAlign.start,
                        controller: _textEditingControllerDependentes,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Número de dependentes:",
                        ),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: ElevatedButton(
                            onPressed: (){
                              _limpar();
                              _textEditingControllerSalarioBruto.clear();
                              _textEditingControllerOutros.clear();
                              _textEditingControllerDependentes.clear();
                            },
                            child: Text(
                              "Limpar",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: ElevatedButton(
                            onPressed: (){
                              _calculate(
                                  _textEditingControllerSalarioBruto.text,
                                  _textEditingControllerOutros.text,
                                  _textEditingControllerDependentes.text

                              );
                            },
                            child: Text(
                              "Calcular",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]
              ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
                border: Border.all(width: 3,color: Colors.black)
            ),
            child: Table(
              children: [
                TableRow(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(width: 1, color: Colors.black),
                        ),
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                            "Eventos"
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(width: 1, color: Colors.black),
                        ),
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                            "Descontos"
                        ),
                      ),
                    ]
                ),
                TableRow(
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                            "Outros"
                        ),
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                            _outros
                        ),
                      ),
                    ]
                ),
                TableRow(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                        ),
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                            "INSS"
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                        ),
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                            _inss
                        ),
                      ),
                    ]
                ),
                TableRow(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                        ),
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                            "IRRF"
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                        ),
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                            _irrf
                        ),
                      ),
                    ]
                ),
                TableRow(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                        ),
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                            "Total"
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                        ),
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                            _total
                        ),
                      ),
                    ]
                ),
                TableRow(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                        ),
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                            "Valor Salário Liquido"
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                        ),
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                            _liquido
                        ),
                      ),
                    ]
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
