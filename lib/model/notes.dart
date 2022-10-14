// ignore_for_file: public_member_api_docs, sort_constructors_first

class Notes {
  int? id;
  String? title;
  String? description;
  DateTime? time;
  Notes({
    this.id,
    this.title,
    this.description,
    this.time,
  });

  Notes copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? time,
  }) {
    return Notes(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
    );
  }

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'id': id,
      'title': title,
      'description': description,
      'time': time?.toIso8601String(),
    };
  }

  factory Notes.fromMap(Map<String, Object?> map) {
    return Notes(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      time: map['time'] != null ? DateTime.parse(map['time'] as String) : null,

      ///.............1
    );
  }

  @override
  String toString() {
    return 'Notes(id: $id, title: $title, description: $description, time: $time)';
  }

  @override
  bool operator ==(covariant Notes other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ description.hashCode ^ time.hashCode;
  }
}
