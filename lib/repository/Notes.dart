import 'package:floor/floor.dart';

@entity
class Notes {
  @primaryKey
  int? id;
  String? name;
  String? note;
  String? link;
  String? date;

  Notes(this.id, this.name, this.note, this.link, this.date);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Notes &&
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
