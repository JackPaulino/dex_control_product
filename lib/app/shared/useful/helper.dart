import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

@Injectable()
class DataBaseHelper {
  Database? _db;

// Classe Product
  final String productModel = 'productTABLE';
  final String idProduct = 'id';
  final String nameProduct = 'name';
  final String img = 'image';
  final String preco = 'price';
  final String quant = 'stock';
  final String dateRegister = 'date_register';

// Classe User
  final String userModel = 'userTABLE';
  final String idUser = 'id';
  final String nameUser = 'name';
  final String password = 'password';

// Classe Logon
  final String loginModel = 'loginTABLE';
  final String idLogin = 'id';
  final String initLogin = 'init_login';
  final String userLoginId = 'user_id';

  Future<Database?> get db async {
    if (_db == null) {
      return await initDb();
    } else {
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'product_list.db');

    var productDB = await openDatabase(path, version: 1, onCreate: _createDB);

    return productDB;
  }

  void _createDB(Database db, int newerVersion) async {
    await db.execute("CREATE TABLE $userModel(" +
        "$idUser INTEGER PRIMARY KEY AUTOINCREMENT," +
        "$nameUser TEXT," +
        "$password TEXT)");

    await db.execute("CREATE TABLE $productModel(" +
        "$idProduct INTEGER PRIMARY KEY AUTOINCREMENT," +
        "$nameProduct TEXT," +
        "$img TEXT," +
        "$preco FLOAT," +
        "$quant FLOAT," +
        "$dateRegister TEXT)");

    await db.execute("CREATE TABLE $loginModel(" +
        "$idLogin INTEGER PRIMARY KEY AUTOINCREMENT," +
        "$initLogin TEXT," +
        "$userLoginId, FOREIGN KEY ($userLoginId) REFERENCES $userModel ($idUser))");
  }

  /*  //Get Card
  Future<List<CardModel>> getAllCard() async {
    Database dbControlMoney = await db;
    List listMap = await dbControlMoney
        .rawQuery("SELECT * FROM $cardModel ORDER BY $maturity");

    List<CardModel> listCard = [];

    for (Map m in listMap) {
      listCard.add(CardModel.fromJson(m));
    }
    return listCard;
  }

  //Get Conta
  Future<List<ContaModel>> getAllConta() async {
    Database dbControlMoney = await db;
    List listMap = await dbControlMoney.rawQuery("SELECT * FROM $contaModel");

    List<ContaModel> listCard = [];

    for (Map m in listMap) {
      listCard.add(ContaModel.fromJson(m));
    }
    return listCard;
  }

  Future<CardModel> getCard(int id) async {
    Database dbControlMoney = await db;
    List<Map> maps = await dbControlMoney.query(cardModel,
        columns: [
          idCard,
          nameCard,
          number,
          valid,
          cvc,
          limite,
          closure,
          maturity,
          statusCard
        ],
        where: "$idCard =?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return CardModel.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteCard(CardModel card) async {
    Database dbControlMoney = await db;
    return await dbControlMoney
        .delete(cardModel, where: "$idCard =?", whereArgs: [card.id]);
  }

  Future<int> updateCard(CardModel card) async {
    Database dbControlMoney = await db;
    return await dbControlMoney.update(cardModel, card.toJson(),
        where: "$idCard =?", whereArgs: [card.id]);
  }

  Future<List> getAllCardOrder(String data) async {
    Database dbControlMoney = await db;
    List listMap = await dbControlMoney.rawQuery(
        "SELECT * FROM $cardModel WHERE $closure LIKE '%$data%' ORDER BY dataColumn");
    List<CardModel> listCard = [];

    for (Map m in listMap) {
      listCard.add(CardModel.fromJson(m));
    }
    return listCard;
  }

  Future<int> getNumber() async {
    Database dbControlMoney = await db;
    return Sqflite.firstIntValue(
        await dbControlMoney.rawQuery("SELECT COUNT(*) FROM $cardModel"));
  }

  Future close() async {
    Database dbControlMoney = await db;
    dbControlMoney.close();
  } */
}
