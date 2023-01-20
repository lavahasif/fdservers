import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../abstract/crudAb.dart';
import '../main.dart';
import '../repository/AppDatabase.dart';
import '../repository/Notes.dart';
import '../repository/Notes_dao.dart';
// import 'package:untitled1/abstract/crudAb.dart';
// import 'package:untitled1/main.dart';
// import 'package:untitled1/repository/AppDatabase.dart';
// import 'package:untitled1/repository/Notes.dart';
// import 'package:untitled1/repository/Notes_dao.dart';

class RegProvider
    with
        ChangeNotifier,
        DiagnosticableTreeMixin,
        crudAb<Notes, List<Notes>, String, void> {
  RegProvider(AppDatabase database, Notesdao notesdao);

  var _greatid = true;
  var _smallid = false;

  get greatid => _greatid;

  set greatid(value) {
    _greatid = value;
    notifyListeners();
  }

  var _notes = Notes(null, null, null, null, null);

  get notes => _notes;

  set notes(value) {
    _notes = value;
    notifyListeners();
  }

  int _maxcount = 0;

  int get maxcount => _maxcount;

  set maxcount(int value) {
    _maxcount = value;
    notifyListeners();
    getMaxCount().then((real) {
      if (real! > value) {
        greatid = true;
      } else {
        greatid = false;
      }
      if (value <= 1) {
        smallid = true;
      } else {
        smallid = false;
      }
    });
  }

  @override
  Notes Create(Notes value) {
    var notesdaos = database!.notesdao;

    notesdaos.insertNotes(value);
    return value;
  }

  @override
  Future Delete(String value) {
    // var notesdao = database!.notesdao;
    var findNotesById = notesdao!.deletebyId(int.parse(value));
    return findNotesById;
  }

  @override
  Future<List<Notes>?> Read(Notes value) {
    // var notesdao = database!.notesdao;
    var findNotesById = notesdao!.findAllNotess();
    return findNotesById;
  }

  @override
  Future<Notes?> ReadbyValue(String value) async {
    // var notesdao = database!.notesdao;
    var findNotesById = notesdao!.findNotesById(int.parse(value));
    findNotesById.then((value) => print(value));
    return findNotesById;
  }

  @override
  Future<void> Update(Notes value) {
    // var notesdao = database!.notesdao;
    var findNotesById = notesdao!.updateNotes(value);

    return findNotesById;
  }

  @override
  Future<int?> getMaxCount() {
    var maxCount = notesdao!.getMaxCount();
    maxCount.then((value) => print("===>$value"));
    return maxCount;
    ;
  }

  get smallid => _smallid;

  set smallid(value) {
    _smallid = value;
    notifyListeners();
  }
  var _isDelete=false;

  get isDelete => _isDelete;

  set isDelete(value) {
    _isDelete = value;
  }
}
