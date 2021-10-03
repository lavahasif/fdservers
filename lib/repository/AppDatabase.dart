// database.dart

// required package imports
import 'dart:async';
import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:untitled1/repository/Notes_dao.dart';

import 'Notes.dart';

part 'AppDatabase.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Notes])
abstract class AppDatabase extends FloorDatabase {
  Notesdao get notesdao;
}

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
