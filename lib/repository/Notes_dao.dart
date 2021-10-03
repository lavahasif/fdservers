import 'package:floor/floor.dart';

import 'Notes.dart';

@dao
abstract class Notesdao {
  @Query('SELECT * FROM Notes WHERE id = :id')
  Future<Notes?> findNotesById(int id);

  @Query('SELECT MAX(id) FROM Notes')
  Future<int?> getMaxCount();

  @Query('SELECT * FROM Notes')
  Future<List<Notes>> findAllNotess();

  @Query('SELECT * FROM Notes')
  Stream<List<Notes>> findAllNotessAsStream();

  @Query('delete from  Notes where id = :id')
  Future<void> deletebyId(int id);

  @insert
  Future<void> insertNotes(Notes Notes);

  @insert
  Future<void> insertNotess(List<Notes> Notess);

  @update
  Future<void> updateNotes(Notes Notes);

  @update
  Future<void> updateNotess(List<Notes> Notes);

  @delete
  Future<void> deleteNotes(Notes Notes);

  @delete
  Future<void> deleteNotess(List<Notes> Notess);
}
