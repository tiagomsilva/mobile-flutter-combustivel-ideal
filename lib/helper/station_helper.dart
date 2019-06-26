import 'package:combustivel_ideal/models/station.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class StationHelper {

  static final StationHelper _instance = StationHelper.internal();

  StationHelper.internal();

  factory StationHelper() => _instance;

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    final path = await getDatabasesPath();
    final pathDB = join(path, "prices.db");

    final String sql =
        "CREATE TABLE STATION (id INTEGER PRIMARY KEY, name TEXT, img TEXT)";

    return await openDatabase(pathDB, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(sql);
    });
  }

  Future<Station> insert(Station station) async {
    Database dbStation = await db;
    station.id = await dbStation.insert("station", station.toMap());
    return station;
  }

  Future<Station> selectById(int id) async {
    Database dbStation = await db;
    List<Map> maps = await dbStation.query("station",
        columns: ["id", "name", "img"], where: "id = ?", whereArgs: [id]);

    if (maps.length > 0) {
      return Station.fromMap(maps.first);
    }

    return null;
  }

  Future<List> selectAll() async {
    Database dbStation = await db;
    List list = await dbStation.rawQuery("SELECT * FROM station");
    List<Station> listStation = List();

    for (Map m in list) {
      listStation.add(Station.fromMap(m));
    }

    return listStation;
  }

  Future<int> update(Station station) async {
    Database dbStation = await db;
    return await dbStation.update("station", station.toMap(),
        where: "id = ?", whereArgs: [station.id]);
  }

  Future<int> delete(Station station) async {
    Database dbStation = await db;
    return await dbStation.delete("station", where: "id = ?", whereArgs: [station.id]);
  }

  Future close() async {
    Database dbStation = await db;
    dbStation.close();
  }
}
