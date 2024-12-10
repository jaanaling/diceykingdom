// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum UserStatus { win, lose, started, finish, played, pause }

class User {
  final String id;
  String name;
  String description;
  UserStatus status;
  DateTime date;
  String boardGame;
  User({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.date,
    required this.boardGame,
  });

  User copyWith({
    String? id,
    String? name,
    String? description,
    UserStatus? status,
    DateTime? date,
    String? boardGame,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      status: status ?? this.status,
      date: date ?? this.date,
      boardGame: boardGame ?? this.boardGame,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'status': status.name,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'boardGame': boardGame,
    };
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, description: $description, status: $status, date: $date, boardGame: $boardGame)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.status == status &&
        other.date == date &&
        other.boardGame == boardGame;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        status.hashCode ^
        date.hashCode ^
        boardGame.hashCode;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      status: UserStatus.values.firstWhere((e) => e.name == map['status']),
      description: map['description'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      boardGame: map['boardGame'] as String,
    );
  }
}
