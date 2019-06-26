import 'package:combustivel_ideal/components/add_stations/image.dart';
import 'package:combustivel_ideal/components/shared/divider.dart';
import 'package:combustivel_ideal/components/shared/raisedButton.dart';
import 'package:combustivel_ideal/components/shared/text.dart';
import 'package:combustivel_ideal/components/shared/textFormField.dart';
import 'package:combustivel_ideal/helper/station_helper.dart';
import 'package:combustivel_ideal/models/station.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddStations extends StatefulWidget {
  @override
  _AddStationsState createState() => _AddStationsState();
}

class _AddStationsState extends State<AddStations> {
  StationHelper stationHelper = StationHelper();
  Station station = Station();

  TextEditingController _stationController = TextEditingController();
  GlobalKey<FormState> _formValidate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBodyPage(),
    );
  }

  Widget buildAppBar() {
    TextComponent text = TextComponent(
      "Adicionar posto",
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

    Column column = Column(children: <Widget>[
      ImageComponent(this.station.img, loadImg),
      DividerComponent(),
      TextFormFieldComponent("Nome do posto", this._stationController, "Informe o nome do posto"),
      DividerComponent(),
      RaisedButtonComponent("Adicionar", function: addStation)
    ]);

    Padding padding = Padding(
      padding: EdgeInsets.only(left: 29.0, right: 29.0, top: 32.0),
      child: column,
    );

    return SingleChildScrollView(
      child: Form(
        key: _formValidate,
        child: padding,
      ),
    );
  }

  void addStation() async {
    if (this._formValidate.currentState.validate()) {
      this.station.name = this._stationController.text;

      await this.stationHelper.insert(this.station).then((stationResult) {
        if (stationResult.id != null && stationResult.id > 0) {
          Navigator.pop(context, stationResult);
        }
      });
    }
  }

  void loadImg() {
    ImagePicker.pickImage(source: ImageSource.camera).then((file) {
      if (file == null) {
        return;
      } else {
        setState(() {
          this.station.img = file.path;
        });
      }
    });
  }
}
