// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDbrootPath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  Notesdao? _notesdaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Notes` (`id` INTEGER, `name` TEXT, `note` TEXT, `link` TEXT, `date` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  Notesdao get notesdao {
    return _notesdaoInstance ??= _$Notesdao(database, changeListener);
  }
}

class _$Notesdao extends Notesdao {
  _$Notesdao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _notesInsertionAdapter = InsertionAdapter(
            database,
            'Notes',
            (Notes item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'note': item.note,
                  'link': item.link,
                  'date': item.date
                },
            changeListener),
        _notesUpdateAdapter = UpdateAdapter(
            database,
            'Notes',
            ['id'],
            (Notes item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'note': item.note,
                  'link': item.link,
                  'date': item.date
                },
            changeListener),
        _notesDeletionAdapter = DeletionAdapter(
            database,
            'Notes',
            ['id'],
            (Notes item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'note': item.note,
                  'link': item.link,
                  'date': item.date
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Notes> _notesInsertionAdapter;

  final UpdateAdapter<Notes> _notesUpdateAdapter;

  final DeletionAdapter<Notes> _notesDeletionAdapter;

  @override
  Future<Notes?> findNotesById(int id) async {
    return _queryAdapter.query('SELECT * FROM Notes WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Notes(
            row['id'] as int?,
            row['name'] as String?,
            row['note'] as String?,
            row['link'] as String?,
            row['date'] as String?),
        arguments: [id]);
  }

  @override
  Future<int?> getMaxCount() async {
    var list = await database.rawQuery("SELECT coalesce(max(id),0) as id FROM Notes");
    return int.parse(list.first["id"].toString()) + 1;
  }

  @override
  Future<List<Notes>> findAllNotess() async {
    return _queryAdapter.queryList('SELECT * FROM Notes',
        mapper: (Map<String, Object?> row) => Notes(
            row['id'] as int?,
            row['name'] as String?,
            row['note'] as String?,
            row['link'] as String?,
            row['date'] as String?));
  }

  @override
  Stream<List<Notes>> findAllNotessAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM Notes',
        mapper: (Map<String, Object?> row) => Notes(
            row['id'] as int?,
            row['name'] as String?,
            row['note'] as String?,
            row['link'] as String?,
            row['date'] as String?),
        queryableName: 'Notes',
        isView: false);
  }

  @override
  Future<void> deletebyId(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from  Notes where id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertNotes(Notes Notes) async {
    await _notesInsertionAdapter.insert(Notes, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertNotess(List<Notes> Notess) async {
    await _notesInsertionAdapter.insertList(Notess, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateNotes(Notes Notes) async {
    await _notesUpdateAdapter.update(Notes, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateNotess(List<Notes> Notes) async {
    await _notesUpdateAdapter.updateList(Notes, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteNotes(Notes Notes) async {
    await _notesDeletionAdapter.delete(Notes);
  }

  @override
  Future<void> deleteNotess(List<Notes> Notess) async {
    await _notesDeletionAdapter.deleteList(Notess);
  }
}
