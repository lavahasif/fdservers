// database.dart

// required package imports
import 'dart:async';
import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:untitled1/repository/Notes_dao.dart';
import 'package:untitled1/repository/Tuts_dao.dart';

import 'Notes.dart';
import 'Tuts.dart';

part 'AppDatabase.g.dart'; // the generated code will be there

@Database(version: 2, entities: [Notes,Tuts])
abstract class AppDatabase extends FloorDatabase {
  Notesdao get notesdao;
  Tutsdao get tutsdao;
}
// create migration
final migration1to2 = Migration(1, 2, (database) async {
  await database.execute('CREATE TABLE IF NOT EXISTS `Tuts` (`id` INTEGER, `name` TEXT, `note` TEXT, `link` TEXT, `date` TEXT, PRIMARY KEY (`id`))');
});
extension DatabaseFactoryExtensions on sqflite.DatabaseFactory {
  Future<String> getDbrootPath(final String name) async {
    var s = await ExtStorage.getExternalStorageDirectory();

    var databasesPath = join(s!, "ssnotes");
    if (Directory(databasesPath).existsSync()) {
      Directory(databasesPath).create();
    }
    // final databasesPath = await this.getDatabasesPath();
    return join(databasesPath, name);
  }
}
// flutter packages pub run build_runner build lib
