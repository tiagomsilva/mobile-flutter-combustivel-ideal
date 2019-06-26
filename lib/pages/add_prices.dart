import 'dart:ui';

import 'package:combustivel_ideal/components/add_prices/datasearch/dataSearch.dart';
import 'package:combustivel_ideal/components/add_prices/textFormFieldStation.dart';
import 'package:combustivel_ideal/components/shared/divider.dart';
import 'package:combustivel_ideal/components/shared/raisedButton.dart';
import 'package:combustivel_ideal/components/shared/text.dart';
import 'package:combustivel_ideal/components/shared/textFormField.dart';
import 'package:combustivel_ideal/helper/price_helper.dart';
import 'package:combustivel_ideal/models/price.dart';
import 'package:combustivel_ideal/models/station.dart';
import 'package:flutter/material.dart';

class AddPrices extends StatefulWidget {
  @override
  _AddPricesState createState() => _AddPricesState();
}

class _AddPricesState extends State<AddPrices> {
  TextEditingController _textNameStationController = TextEditingController();
  TextEditingController _textEthanolController = TextEditingController();
  TextEditingController _textGasolineController = TextEditingController();

  GlobalKey<FormState> _formValidation = GlobalKey<FormState>();

  PriceHelper priceHelper = PriceHelper();
  Station stationSelected;

  String descriptionResult = "";
  String result = "";

  @override
  void initState() {
    super.initState();
    _textEthanolController.addListener(onChange);
    _textGasolineController.addListener(onChange);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBodyPage(),
    );
  }

  Widget buildAppBar() {
    TextComponent text = TextComponent(
      "Calcular combustivel ideal",
      color: Colors.white,
      fontWeight: FontWeight.bold,
      size: 16.0,
    );

    return AppBar(
      title: text,
      centerTitle: true,
    );
  }

  Widget buildBodyPage() {
    Column column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DividerComponent(),
        TextFormFieldStationComponent(
            this._textNameStationController, openSearch),
        DividerComponent(),
        TextFormFieldComponent(
          "Preço do Etanol",
          this._textEthanolController,
          "Informe o preço do ethanol",
          typeKeyboard: TextInputType.number,
          sufixText: "R\$",
        ),
        DividerComponent(),
        TextFormFieldComponent(
          "Preço da Gasolina",
          this._textGasolineController,
          "Informe o preço da gasolina",
          typeKeyboard: TextInputType.number,
          sufixText: "R\$",
        ),
        DividerComponent(),
        Row(
          children: <Widget>[
            TextComponent("$descriptionResult", size: 12.0),
            TextComponent(
              "$result",
              size: 12.0,
              fontWeight: FontWeight.bold,
              color: this.result == "gasolina" ? Colors.amber : Colors.green,
            ),
          ],
        ),
        DividerComponent(),
        RaisedButtonComponent(
          "Adicionar",
          function: addPrices,
        )
      ],
    );

    Padding padding = Padding(
      padding: EdgeInsets.only(left: 29.0, right: 29.0),
      child: column,
    );

    return SingleChildScrollView(
      child: Form(key: this._formValidation, child: padding),
    );
  }

  openSearch() {
    showSearch(context: context, delegate: DataSearch()).then((result) {
      if (result != null) {
        this.stationSelected = result;
        this._textNameStationController.text = result.name;
      } else {
        this.stationSelected = null;
        this._textNameStationController.text = "";
      }
    });
  }

  void addPrices() {
    if (this._formValidation.currentState.validate()) {
      Price price = Price();
      price.station = this.stationSelected;
      price.valueEthanol =
          double.parse(_textEthanolController.text.replaceAll(",", "."));
      price.valueGasoline =
          double.parse(_textGasolineController.text.replaceAll(",", "."));

      this.priceHelper.insert(price).then((result) {
        if (result.id != null && result.id > 0) {
          Navigator.pop(context, result);
        }
      });
    }
  }

  onChange() {
    double ethanol = 0.0;
    double gasoline = 0.0;

    if (_textGasolineController != null &&
        _textGasolineController.text.isEmpty != true) {
      gasoline =
          double.parse(_textGasolineController.text.replaceAll(",", "."));
    } else {
      result = "";
      descriptionResult = "";
      return;
    }

    if (_textEthanolController != null &&
        _textEthanolController.text.isEmpty != true) {
      ethanol = double.parse(_textEthanolController.text.replaceAll(",", "."));
    } else {
      result = "";
      descriptionResult = "";
      return;
    }

    String textDescriptionResult = "O combustível mais rentável é a ";
    String textResult = "gasolina";

    if ((ethanol / gasoline) < 0.7) {
      textDescriptionResult = "O combustível mais rentável é o ";
      textResult = "etanol";
    }

    setState(() {
      descriptionResult = textDescriptionResult;
      result = textResult;
    });
  }
}
