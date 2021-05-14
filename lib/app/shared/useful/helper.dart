import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

@Injectable()
class DataBaseHelper {
  Database? _db;

// Classe Product
  final String productModel = 'productTABLE';
  final String idProduct = 'id';
  final String codprod = 'codigo';
  final String nameProduct = 'name';
  final String image = 'image';
  final String price = 'price';
  final String stock = 'stock';
  final String dateModify = 'date_modify';

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
        "$codprod INTEGER," +
        "$nameProduct TEXT," +
        "$image TEXT," +
        "$price FLOAT," +
        "$stock FLOAT," +
        "$dateModify TEXT)");

    await db.execute("CREATE TABLE $loginModel(" +
        "$idLogin INTEGER PRIMARY KEY AUTOINCREMENT," +
        "$initLogin TEXT," +
        "$userLoginId, FOREIGN KEY ($userLoginId) REFERENCES $userModel ($idUser))");
  }
}
