// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Task {
  final String id;
  final String title;
  final DateTime? dueDate;
  final DateTime? finishDate;
  final bool isPeriodic;
  final int periodicityDays;
  final String? pondId;

  Task({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.finishDate,
    required this.isPeriodic,
    required this.periodicityDays, // Добавлено поле
    required this.pondId,
  });

  Task copyWith({
    String? id,
    String? title,
    DateTime? dueDate,
    DateTime? finishDate,
    bool? isPeriodic,
    int? periodicityDays,
    String? pondId,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      finishDate: finishDate ?? this.finishDate,
      isPeriodic: isPeriodic ?? this.isPeriodic,
      periodicityDays: periodicityDays ?? this.periodicityDays,
      pondId: pondId ?? this.pondId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'dueDate': dueDate?.millisecondsSinceEpoch,
      'finishDate': finishDate?.millisecondsSinceEpoch,
      'isPeriodic': isPeriodic,
      'periodicityDays': periodicityDays, // Сохраняем количество дней
      'pondId': pondId,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      dueDate: map['dueDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dueDate'] as int)
          : null,
      finishDate: map['finishDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['finishDate'] as int)
          : null,
      isPeriodic: map['isPeriodic'] as bool,
      periodicityDays: map['periodicityDays'] as int, // Читаем значение
      pondId: map['pondId'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  Task markAsCompleted() {
    if (!isPeriodic || periodicityDays <= 0) {
      return copyWith(finishDate: DateTime.now());
    }

    DateTime newDueDate = dueDate!.add(Duration(days: periodicityDays));
    return copyWith(
      finishDate: DateTime.now(),
      dueDate: newDueDate,
    );
  }

  @override
  String toString() {
    return 'Task(id: $id, title: $title, dueDate: $dueDate, finishDate: $finishDate, isPeriodic: $isPeriodic, periodicityDays: $periodicityDays, pondId: $pondId)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.dueDate == dueDate &&
      other.finishDate == finishDate &&
      other.isPeriodic == isPeriodic &&
      other.periodicityDays == periodicityDays &&
      other.pondId == pondId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      dueDate.hashCode ^
      finishDate.hashCode ^
      isPeriodic.hashCode ^
      periodicityDays.hashCode ^
      pondId.hashCode;
  }
}
