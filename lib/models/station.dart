class Station {
  int id;
  String name;
  String img;

  Station();

  Station.fromMap(Map map) {
    this.id = map["id"];
    this.name = map["name"];
    this.img = map["img"];
  }

  Map toMap() {
    Map<String, dynamic> map = {"name": this.name, "img": this.img};

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "Station [id: $this.id, name: $this.name]";
  }
}
