// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum ChallengeStatus { start, lock, unlock, finish, skip }

class Challenge {
  final String name;
  final String text;
  final int difficulty;
  final ChallengeStatus status;

  Challenge({
    required this.name,
    required this.text,
    required this.difficulty,
    this.status = ChallengeStatus.lock,
  });

  Challenge copyWith({
    String? name,
    String? text,
    int? difficulty,
    ChallengeStatus? status,
  }) {
    return Challenge(
      name: name ?? this.name,
      text: text ?? this.text,
      difficulty: difficulty ?? this.difficulty,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'text': text,
      'difficulty': difficulty,
      'status': status.index,
    };
  }

  factory Challenge.fromMap(Map<String, dynamic> map) {
    return Challenge(
      name: map['name'] as String,
      text: map['text'] as String,
      difficulty: map['difficulty'] as int,
      status: ChallengeStatus.values[map['status'] as int],
    );
  }

  String toJson() => json.encode(toMap());

  factory Challenge.fromJson(String source) =>
      Challenge.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Challenge(name: $name, text: $text, difficulty: $difficulty)';

  @override
  bool operator ==(covariant Challenge other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.text == text &&
        other.status == status &&
        other.difficulty == difficulty;
  }

  @override
  int get hashCode => name.hashCode ^ text.hashCode ^ difficulty.hashCode;
}


void checkAndUnlockNextDifficulty(int currentDifficulty, List<Challenge> challenges) {
  // Фильтруем задания текущей сложности
  List<Challenge> currentChallenges = challenges
      .where((c) => c.difficulty == currentDifficulty)
      .toList();

  // Общее количество заданий на текущем уровне сложности
  int totalChallenges = currentChallenges.length;

  // Количество завершенных заданий
  int completedChallenges = currentChallenges
      .where((c) => c.status == ChallengeStatus.finish)
      .length;

  // Проверяем, завершена ли половина заданий
  if (completedChallenges >= (totalChallenges / 2).ceil()) {
    int nextDifficulty = currentDifficulty + 1;

    // Разблокируем задания следующей сложности
    for (int i = 0; i < challenges.length; i++) {
      if (challenges[i].difficulty == nextDifficulty &&
          challenges[i].status == ChallengeStatus.lock) {
        challenges[i] = challenges[i].copyWith(status: ChallengeStatus.unlock);
      }
    }
  }
}

void completeChallenge(Challenge challenge, List<Challenge> challenges) {
  // Обновляем статус текущего задания
  int index = challenges.indexOf(challenge);
  challenges[index] = challenge.copyWith(status: ChallengeStatus.finish);

  // Проверяем, нужно ли разблокировать следующую сложность
  checkAndUnlockNextDifficulty(challenge.difficulty, challenges);
}