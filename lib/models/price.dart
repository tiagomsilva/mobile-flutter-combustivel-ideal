import 'package:combustivel_ideal/models/station.dart';

class Price {
  int id;
  Station station;
  double valueEthanol;
  double valueGasoline;

  Price();

  Price.fromMap(Map map) {
    this.id = map["id"];
    this.valueEthanol = map["valueEthanol"];
    this.valueGasoline = map["valueGasoline"];

    this.station = Station();
    this.station.id = map["id_station"];
    this.station.name = map["name"];
    this.station.img = map["img"];

    /* StationHelper stationHelper = StationHelper();
    stationHelper.selectById(map["id_station"]).then((result) {
      this.station = result;
    });*/
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "valueEthanol": this.valueEthanol,
      "valueGasoline": this.valueGasoline,
      "id_station": this.station.id
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "Price [id: $this.id, "
        "valor do etanol: $this.valueEthanol, "
        "valor ga gasolina: $this.valueGasoline, "
        "id do posto: $this.station.id, "
        "]";
  }
}
