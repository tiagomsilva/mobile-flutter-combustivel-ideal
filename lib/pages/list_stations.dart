import 'package:combustivel_ideal/components/list_prices/fieldSearch.dart';
import 'package:combustivel_ideal/components/shared/ItemImageList.dart';
import 'package:combustivel_ideal/components/shared/text.dart';
import 'package:combustivel_ideal/helper/price_helper.dart';
import 'package:combustivel_ideal/models/price.dart';
import 'package:combustivel_ideal/pages/add_prices.dart';
import 'package:flutter/material.dart';

class ListStations extends StatefulWidget {
  @override
  _ListStationsState createState() => _ListStationsState();
}

class _ListStationsState extends State<ListStations> {
  TextEditingController _controllerSearch = TextEditingController();

  PriceHelper priceHelper = PriceHelper();
  List<Price> listPrices = List();
  List<Price> listPricesFilter = List();
  int countResults = 0;

  void loadAllPrices() {
    priceHelper.selectAll().then((result) {
      setState(() {
        if (result != null) {
          listPrices = result.reversed.toList();
          listPricesFilter = listPrices;
          countResults = listPricesFilter.length;
        }
      });
    });
  }

  void onChangeSource() {
    if (_controllerSearch.text == null || _controllerSearch.text.isEmpty) {
      setState(() {
        listPricesFilter = listPrices;
          countResults = listPricesFilter.length;
      });
    } else {
      setState(() {
        listPricesFilter = listPrices
            .where((f) => f.station.name
                .toLowerCase()
                .startsWith(_controllerSearch.text.toLowerCase()))
            .toList();
          countResults = listPricesFilter.length;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controllerSearch.addListener(onChangeSource);
    this.loadAllPrices();
  }

  @override
  Widget build(BuildContext context) {
    Column column = Column(
      children: <Widget>[
        buildHeaderPage(),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 8.0, left: 8.0),
          height: 30.0,
          color: Color(0xffEBEBEB),
          child: TextComponent(
            "$countResults resultados encontrados",
            size: 12.0,
          ),
        ),
        buildBobyPage(),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: column,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddPrices()))
              .then((result) {
            this.loadAllPrices();
          });
        },
      ),
    );
  }

  Widget buildHeaderPage() {
    return Container(
      height: 79.0,
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FieldSearchComponent(this._controllerSearch),
        ],
      ),
    );
  }

  Widget buildBobyPage() {
    return Container(
      height: (80.0 * this.countResults),
      child: ListView.builder(
        itemCount: listPricesFilter.length,
        itemBuilder: (context, index) {
          String gasoline = listPricesFilter[index]
              .valueGasoline
              .toString()
              .replaceAll(".", ",");
          String ethanol = listPricesFilter[index]
              .valueEthanol
              .toString()
              .replaceAll(".", ",");

          String ideal = "Gasolina";

          if ((listPricesFilter[index].valueEthanol /
                  listPricesFilter[index].valueGasoline) <
              0.7) {
            ideal = "Etanol";
          }

          return Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: ListTile(
              leading: ItemImageListComponent(
                  listPricesFilter[index].station.img, 60.0),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextComponent(
                        listPricesFilter[index].station.name,
                        fontWeight: FontWeight.bold,
                        size: 14.0,
                      ),
                      TextComponent(
                        ideal,
                        fontWeight: FontWeight.bold,
                        size: 14.0,
                        color: ideal == "Etanol" ? Colors.green : Colors.amber,
                      )
                    ],
                  ),
                  TextComponent(
                    "Gasolina: $gasoline",
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    size: 14.0,
                  ),
                  TextComponent(
                    "Etanol: $ethanol",
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    size: 14.0,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
