import 'package:combustivel_ideal/models/price.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PriceHelper {
  static final PriceHelper _instance = PriceHelper.internal();

  PriceHelper.internal();

  factory PriceHelper() => _instance;

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

    final String sql = "CREATE TABLE PRICE (id INTEGER PRIMARY KEY, "
        "valueEthanol REAL, "
        "valueGasoline REAL, "
        "id_station INTEGER, "
        "FOREIGN KEY(id_station) REFERENCES station(id)"
        ");";

    final String sql2 =
        "CREATE TABLE STATION (id INTEGER PRIMARY KEY, name TEXT, img TEXT)";

    return await openDatabase(pathDB, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(sql);
      await db.execute(sql2);
    });
  }

  Future<Price> insert(Price price) async {
    Database dbPrice = await db;
    price.id = await dbPrice.insert("price", price.toMap());
    return price;
  }

  Future<List> selectAll({int id}) async {
    Database dbPrice = await db;

    String sql = "SELECT t1.id, "
        "t1.valueEthanol, "
        "t1.valueGasoline, "
        "t1.id_station, "
        "t2.name, "
        "t2.img FROM price AS t1 INNER JOIN station AS t2 on (t1.id_station = t2.id) ";


    if (id != null) {
      sql += "WHERE ID = $id";
    }

    List list = await dbPrice.rawQuery(
      sql,
    );

    List<Price> listPrice = List();

    for (Map m in list) {
      listPrice.add(Price.fromMap(m));
    }

    return listPrice;
  }

  Future<int> update(Price price) async {
    Database dbPrice = await db;
    return await dbPrice
        .update("price", price.toMap(), where: "id = ?", whereArgs: [price.id]);
  }

  Future<int> delete(Price price) async {
    Database dbPrice = await db;
    return await dbPrice
        .delete("price", where: "id = ?", whereArgs: [price.id]);
  }

  Future close() async {
    Database dbPrice = await db;
    dbPrice.close();
  }
}
