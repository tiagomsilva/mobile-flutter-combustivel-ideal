import 'package:combustivel_ideal/components/shared/ItemImageList.dart';
import 'package:combustivel_ideal/helper/station_helper.dart';
import 'package:combustivel_ideal/models/station.dart';
import 'package:combustivel_ideal/pages/add_stations.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<Station> {
  List<Station> listStation = List();
  List<Station> listStationRecents = List();

  StationHelper _stationHelper = StationHelper();
  int posSelected;

  DataSearch() {
    loadStations();
  }

  void loadStations() {
    this._stationHelper.selectAll().then((listResult) {
      this.listStation = listResult;

      listStationRecents = this.listStation.reversed.toList();

      if (listStationRecents.length > 10) {
        int cont = listStationRecents.length;

        while (cont > 10) {
          listStation.removeLast();
          cont--;
        }
      }
    });
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionsList = query.isEmpty
        ? this.listStationRecents
        : this
            .listStation
            .where((c) => c.name.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        if (index != suggestionsList.length) {
          return buildListSuggestions(
              context,
              suggestionsList,
              index,
              ItemImageListComponent(suggestionsList[index].img, 40.0),
              buildTitleListSuggestions(suggestionsList, index));
        } else {
          return ListTile(
            onTap: () {
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddStations()))
                  .then((value) {
                this.loadStations();
              });
            },
            leading: Icon(
              Icons.add,
              color: Colors.blue,
            ),
            title: Text(
              "Adicionar posto",
              style: TextStyle(color: Colors.blue),
            ),
          );
        }
      },
      itemCount: (suggestionsList.length + 1),
    );
  }

  Widget buildListSuggestions(BuildContext context,
      List<Station> suggestionsList, int index, Widget leading, Widget title) {
    return ListTile(
      onTap: () {
        Navigator.pop(context, suggestionsList[index]);
      },
      leading: leading,
      title: title,
    );
  }

  Widget buildTitleListSuggestions(List<Station> suggestionsList, int index) {
    return RichText(
      text: TextSpan(
          text: suggestionsList[index].name.substring(0, query.length),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          children: [
            TextSpan(
                text: suggestionsList[index].name.substring(query.length),
                style: TextStyle(color: Colors.grey)),
          ]),
    );
  }
}
