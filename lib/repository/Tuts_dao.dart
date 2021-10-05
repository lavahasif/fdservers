import 'package:floor/floor.dart';

import 'Tuts.dart';

@dao
abstract class Tutsdao {
  @Query('SELECT * FROM Tuts WHERE id = :id')
  Future<Tuts?> findTutsById(int id);

  @Query('SELECT MAX(id) FROM Tuts')
  Future<int?> getMaxCount();

  @Query('SELECT * FROM Tuts')
  Future<List<Tuts>> findAllTutss();

  @Query('SELECT * FROM Tuts')
  Stream<List<Tuts>> findAllTutssAsStream();

  @Query('delete from  Tuts where id = :id')
  Future<void> deletebyId(int id);

  @insert
  Future<void> insertTuts(Tuts Tuts);

  @insert
  Future<void> insertTutss(List<Tuts> Tutss);

  @update
  Future<void> updateTuts(Tuts Tuts);

  @update
  Future<void> updateTutss(List<Tuts> Tuts);

  @delete
  Future<void> deleteTuts(Tuts Tuts);

  @delete
  Future<void> deleteTutss(List<Tuts> Tutss);
}
