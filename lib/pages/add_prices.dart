import 'package:combustivel_ideal/components/divider.dart';
import 'package:combustivel_ideal/components/text.dart';
import 'package:combustivel_ideal/components/textField.dart';
import 'package:flutter/material.dart';

class AddPrices extends StatefulWidget {
  @override
  _AddPricesState createState() => _AddPricesState();
}

class _AddPricesState extends State<AddPrices> {
  @override
  Widget build(BuildContext context) {
    TextComponent text = TextComponent(
      "Calcular combustivel ideal",
      color: Colors.white,
      fontWeight: FontWeight.bold,
      size: 16.0,
    );

    Column column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DividerComponent(),
        TextFieldComponent(
          "Posto de Combustível",
          prefixIcon: Icon(Icons.search),
        ),
        DividerComponent(),
        _textField("Preço do Etanol"),
        DividerComponent(),
        _textField("Preço da Gasolina"),
        DividerComponent(),
        TextComponent("O combustível mais rentável é: ", size: 12.0,),
        DividerComponent(),
        SizedBox(
          width: double.infinity,
          child: RaisedButton(
            child: Text("Adicionar"),
            color: Color(0xff314257),
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0)),
            onPressed: () {},
          ),
        )
      ],
    );

    Padding padding = Padding(
      padding: EdgeInsets.only(left: 29.0, right: 29.0),
      child: column,
    );

    return Scaffold(
        appBar: AppBar(
          title: text,
          centerTitle: true,
          backgroundColor: Color(0xff314257),
        ),
        body: SingleChildScrollView(
          child: padding,
        ));
  }

  Widget _textField(String text) {
    return TextFieldComponent(
      text,
      prefixText: " R\$ ",
      keyboardType: TextInputType.number,
    );
  }
}
