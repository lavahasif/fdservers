import 'package:floor/floor.dart';

@entity
class Tuts {
  @primaryKey
  int? id;
  String? name;
  String? note;
  String? link;
  String? date;

  Tuts(this.id, this.name, this.note, this.link, this.date);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Tuts &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            link == other.link;
  }

  @override
  int get hashCode => id.hashCode ^ link.hashCode;

  @override
  String toString() {
    return 'Task{id: $id, message: $link}';
  }
}
