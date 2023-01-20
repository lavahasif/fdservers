import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../abstract/crudAb.dart';
import '../main.dart';
import '../repository/AppDatabase.dart';
import '../repository/Tuts.dart';
import '../repository/Tuts_dao.dart';
// import 'package:untitled1/abstract/crudAb.dart';
// import 'package:untitled1/main.dart';
// import 'package:untitled1/repository/AppDatabase.dart';
// import 'package:untitled1/repository/Tuts.dart';
// import 'package:untitled1/repository/Tuts_dao.dart';

class RegProvider
    with
        ChangeNotifier,
        DiagnosticableTreeMixin,
        crudAb<Tuts, List<Tuts>, String, void> {
  RegProvider(AppDatabase database, Tutsdao Tutsdao);

  var _greatid = true;
  var _smallid = false;

  get greatid => _greatid;

  set greatid(value) {
    _greatid = value;
    notifyListeners();
  }

  var _tuts = Tuts(null, null, null, null, null);

  get tuts => _tuts;

  set tuts(value) {
    _tuts = value;
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
  Tuts Create(Tuts value) {
    var Tutsdaos = database!.tutsdao;

    Tutsdaos.insertTuts(value);
    return value;
  }

  @override
  Future Delete(String value) {
    // var Tutsdao = database!.Tutsdao;
    var findTutsById = tutsdao!.deletebyId(int.parse(value));
    return findTutsById;
  }

  @override
  Future<List<Tuts>?> Read(Tuts value) {
    // var Tutsdao = database!.Tutsdao;
    var findTutsById = tutsdao!.findAllTutss();
    return findTutsById;
  }

  @override
  Future<Tuts?> ReadbyValue(String value) async {
    // var Tutsdao = database!.Tutsdao;
    var findTutsById = tutsdao!.findTutsById(int.parse(value));
    findTutsById.then((value) => print(value));
    return findTutsById;
  }

  @override
  Future<void> Update(Tuts value) {
    // var Tutsdao = database!.Tutsdao;
    var findTutsById = tutsdao!.updateTuts(value);

    return findTutsById;
  }

  @override
  Future<int?> getMaxCount() {
    var maxCount = tutsdao!.getMaxCount();
    maxCount.then((value) => print("===>$value"));
    return maxCount;
    ;
  }

  get smallid => _smallid;

  set smallid(value) {
    _smallid = value;
    notifyListeners();
  }

  var _isDelete = false;

  get isDelete => _isDelete;

  set isDelete(value) {
    _isDelete = value;
  }
}
