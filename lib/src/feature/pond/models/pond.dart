// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:pond_care/src/core/utils/log.dart';

import 'package:pond_care/src/feature/pond/models/decoration.dart';
import 'package:pond_care/src/feature/pond/models/fish.dart';
import 'package:pond_care/src/feature/pond/models/plant.dart';
import 'package:pond_care/src/feature/pond/models/task.dart';

class Pond {
  final String id;
  String name;
  double volume; // Объем в литрах
  String? photoUrl;
  List<Fish> fish;
  List<Plant> plants;
  List<Decorations> decorations;
  List<Task>? tasks;

  double pollutionLevel; // Уровень загрязнения воды

  Pond({
    required this.id,
    required this.name,
    required this.volume,
    this.photoUrl,
    required this.fish,
    required this.tasks,
    required this.plants,
    required this.decorations,
    this.pollutionLevel = 0.0,
  });

  /// Метод для получения рекомендованных рыб для текущего состояния пруда
  List<Fish> getRecommendedFish(List<Fish> fish) {
    List<Fish> recommendedFish = [];

    for (final f in fish) {
      if (checkFishCompatibilityWith(f)) {
        recommendedFish.add(f);
      }
    }

    return recommendedFish;
  }

  /// Метод для проверки совместимости конкретной рыбы с другими рыбами в пруду
  bool checkFishCompatibilityWith(Fish newFish) {
    for (final f in fish) {
      if (!newFish.recommendedFish.contains(f.id) ||
          !f.recommendedFish.contains(newFish.id)) {
        return false;
      }
      if (newFish.aggressive && f.size != "large") {
        return false; // Агрессивная рыба несовместима с мелкими рыбами
      }
    }
    return true;
  }

  /// Метод для получения рекомендованных растений для текущего состояния пруда
  List<Plant> getRecommendedPlants(List<Plant> plants) {
    List<Plant> recommendedPlants = [];

    for (final p in plants) {
      if (checkPlantCompatibilityWith(p)) {
        recommendedPlants.add(p);
      }
    }

    return recommendedPlants;
  }

  /// Метод для проверки совместимости конкретного растения с текущими условиями пруда
  bool checkPlantCompatibilityWith(Plant plant) {
    if (pollutionLevel > 50.0 && plant.sensitiveToPollution) {
      return false; // Растение чувствительно к загрязнению воды
    }
    return true;
  }

  /// Метод для получения рекомендованных декораций для текущего состояния пруда
  List<Decorations> getRecommendedDecorations(List<Decorations> decorations) {
    List<Decorations> recommendedDecorations = [];

    for (final d in decorations) {
      if (checkDecorationCompatibilityWith(d)) {
        recommendedDecorations.add(d);
      }
    }

    return recommendedDecorations;
  }

  /// Метод для проверки совместимости конкретной декорации с текущим состоянием пруда
  bool checkDecorationCompatibilityWith(Decorations decoration) {
    if (!decoration.safeForFish ||
        decoration.pollutantSource ||
        decoration.blocksSwimming) {
      return false; // Декорация небезопасна для рыб
    }
    return true;
  }

  /// Метод для проверки совместимости рыб
  bool checkFishCompatibility() {
    for (int i = 0; i < fish.length; i++) {
      for (int j = i + 1; j < fish.length; j++) {
        final Fish fishA = fish[i];
        final Fish fishB = fish[j];
        if (!fishA.recommendedFish.contains(fishB.id) ||
            !fishB.recommendedFish.contains(fishA.id)) {
          return false; // Рыбы несовместимы
        }
        if (fishA.aggressive && fishB.size != "large") {
          return false; // Агрессивная рыба несовместима с более мелкими рыбами
        }
      }
    }
    return true;
  }

  /// Метод для проверки совместимости растений с текущим состоянием пруда
  bool checkPlantCompatibility() {
    for (final plant in plants) {
      if (pollutionLevel > 50.0 && plant.sensitiveToPollution) {
        return false; // Растение чувствительно к загрязнению воды
      }
    }
    return true;
  }

  /// Метод для проверки совместимости декораций
  bool checkDecorationSafety() {
    for (final decoration in decorations) {
      if (!decoration.safeForFish ||
          decoration.pollutantSource ||
          decoration.blocksSwimming) {
        return false; // Декорация небезопасна
      }
    }
    return true;
  }

  /// Проверка уровня кислорода в пруду
  bool checkOxygenLevel() {
    double totalOxygenNeeded = 0.0;

    // Добавляем потребности рыб
    for (final f in fish) {
      totalOxygenNeeded += (f.minOxygenLevel + f.maxOxygenLevel) / 2;
    }

    // Добавляем выход кислорода от растений
    double oxygenProvided = 0.0;
    for (final p in plants) {
      oxygenProvided += p.oxygenOutput;
    }

    return oxygenProvided >= totalOxygenNeeded;
  }

  /// Метод для проверки совместимости всех элементов в пруду
  bool checkPondCompatibility() {
    return checkFishCompatibility() &&
        checkPlantCompatibility() &&
        checkDecorationSafety() &&
        checkOxygenLevel();
  }

  bool checkSwimmingZones() {
    final Map<String, int> swimmingZones = {
      "surface": 0,
      "middle": 0,
      "bottom": 0,
    };

    for (final f in fish) {
      swimmingZones[f.swimmingZone] = swimmingZones[f.swimmingZone]! + 1;
    }

    return swimmingZones.values
        .every((count) => count < 10); // Максимум 10 рыб в одной зоне
  }

  Map<String, String> checkElementCountsBySize() {
    final Map<String, String> warnings = HashMap();
    final Map<String, int> sizeData = calculateMaxElementsBySize();

    if (sizeData['currentFishUnits']! > sizeData['maxUnits']!) {
      warnings['Decorations'] = 'The scenery takes up too much space.';
    }

    return warnings;
  }

  Map<String, int> calculateMaxElementsBySize() {
    final int maxUnits =
        (volume / 50).floor(); // Каждая условная единица требует 50 литров воды
    final int currentFishUnits =
        fish.fold(0, (sum, f) => sum + _getSizeUnit(f.size));

    return {
      'maxUnits': maxUnits,
      'currentFishUnits': currentFishUnits,
    };
  }

  /// Вспомогательный метод для получения условной единицы размера
  int _getSizeUnit(String size) {
    switch (size) {
      case 'small':
        return 1;
      case 'medium':
        return 2;
      case 'large':
        return 3;
      default:
        return 1; // Значение по умолчанию
    }
  }

  Map<String, String> getErrors() {
    final Map<String, String> recommendations = HashMap();
    // Проверяем совместимость рыб
    if (!checkFishCompatibility()) {
      recommendations['Fish'] = 'Some fish are in conflict with each other.';
    }

    // Проверяем безопасность декораций
    if (!checkDecorationSafety()) {
      recommendations['Decorations'] = 'Some decorations are unsafe for fish.';
    }

    // Проверяем уровень кислорода
    if (!checkOxygenLevel()) {
      recommendations['Oxygen'] =
          'There is not enough oxygen. It is recommended to add plants or increase the pump power.';
    }

    recommendations.addAll(checkElementCountsBySize());
    return recommendations;
  }

  Map<String, String> getRecommendations() {
    final Map<String, String> recommendations = HashMap();

    // Проверяем вместимость элементов

    // Добавляем рекомендации по количеству рыб, растений и декораций в зависимости от их размера
    final Map<String, int> maxElements = calculateMaxElementsBySize();

    // Рекомендации для рыб
    final int maxFish =
        maxElements['maxUnits']! - maxElements['currentFishUnits']!;
    recommendations['Fish Capacity'] =
        'Recommended number of elements: $maxFish';

    // Рекомендации для растений

    // Добавляем рекомендации по грунту
    final String recommendedGround = calculateRecommendedGroundType();

    recommendations['Ground Type'] =
        'Recommended type of soil: $recommendedGround.';

    // Проверяем зоны плавания
    if (!checkSwimmingZones()) {
      recommendations['Swimming Zones'] =
          'There are too many fish in one swimming area.';
    }

    // Добавляем рекомендации по мощности насоса
    final double recommendedPumpPower = calculatePumpPower();

    recommendations['Pump Power'] =
        'Recommended pump power: ${recommendedPumpPower.toStringAsFixed(1)}.';

    // Добавляем рекомендации по очистке воды
    if (pollutionLevel > 50.0) {
      recommendations['Water Purification'] =
          'High level of pollution. It is recommended to increase the number of plants or use filters.';
    }

    return recommendations;
  }

  double calculatePumpPower() {
    // Базовое требование: 1 литр воды = 1 литр/час мощности насоса
    final double basePumpPower = volume / 2;

    // Дополнительное требование на каждую рыбу
    final double fishPumpRequirement = fish.fold(0.0, (sum, f) {
      switch (f.size) {
        case 'small':
          return sum + 5.0; // Маленькая рыба добавляет 5 л/ч
        case 'medium':
          return sum + 10.0; // Средняя рыба добавляет 10 л/ч
        case 'large':
          return sum + 20.0; // Большая рыба добавляет 20 л/ч
        default:
          return sum;
      }
    });

    // Дополнительное требование на каждую декорацию
    final double decorationPumpRequirement = decorations.fold(0.0, (sum, d) {
      switch (d.size) {
        case 'small':
          return sum + 2.0; // Маленькая декорация добавляет 2 л/ч
        case 'medium':
          return sum + 5.0; // Средняя декорация добавляет 5 л/ч
        case 'large':
          return sum + 10.0; // Большая декорация добавляет 10 л/ч
        default:
          return sum;
      }
    });

    // Увеличиваем мощность на 20% при высоком уровне загрязнения
    final double pollutionFactor = pollutionLevel > 50.0 ? 1.2 : 1.0;

    // Суммируем все требования и применяем коэффициент загрязнения
    final double requiredPumpPower =
        (basePumpPower + fishPumpRequirement + decorationPumpRequirement) *
            pollutionFactor;

    return requiredPumpPower;
  }

  /// Расчёт рекомендуемого типа грунта
  String calculateRecommendedGroundType() {
    final Map<String, int> groundPreferences = {
      'sand': 0,
      'gravel': 0,
      'clay': 0,
      'soil': 0,
      'grass': 0,
      'dirt': 0
    };

    for (final f in fish) {
      groundPreferences[f.groundPreference] =
          groundPreferences[f.groundPreference]?? 0 + 1;
    }

    for (final p in plants) {
      groundPreferences[p.groundPreference] =
          groundPreferences[p.groundPreference]?? 0 + 1;
    }

    return groundPreferences.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  Pond copyWith({
    String? id,
    String? name,
    double? volume,
    String? photoUrl,
    List<Fish>? fish,
    List<Plant>? plants,
    List<Decorations>? decorations,
    List<Task>? tasks,
    String? groundType,
    double? currentOxygenLevel,
    double? currentTemperature,
    double? pumpPower,
    double? pollutionLevel,
  }) {
    return Pond(
      id: id ?? this.id,
      name: name ?? this.name,
      tasks: tasks ?? this.tasks,
      volume: volume ?? this.volume,
      photoUrl: photoUrl ?? this.photoUrl,
      fish: fish ?? this.fish,
      plants: plants ?? this.plants,
      decorations: decorations ?? this.decorations,
      pollutionLevel: pollutionLevel ?? this.pollutionLevel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'volume': volume,
      'tasks': tasks?.map((x) => x.toMap()).toList(),
      'photoUrl': photoUrl,
      'fish': fish.map((x) => x.toMap()).toList(),
      'plants': plants.map((x) => x.toMap()).toList(),
      'decorations': decorations.map((x) => x.toMap()).toList(),
      'pollutionLevel': pollutionLevel,
    };
  }

  factory Pond.fromMap(Map<String, dynamic> map) {
    logger.e('Incoming map: $map');
    return Pond(
      id: map['id'] as String? ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      name: map['name'] as String,
      tasks: List<Task>.from(
        (map['tasks'] as List<dynamic>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
      volume: map['volume'] as double,
      photoUrl: map['photoUrl'] as String?,
      fish: List<Fish>.from(
        (map['fish'] as List<dynamic>).map<Fish>(
          (x) => Fish.fromMap(x as Map<String, dynamic>),
        ),
      ),
      plants: List<Plant>.from(
        (map['plants'] as List<dynamic>).map<Plant>(
          (x) => Plant.fromMap(x as Map<String, dynamic>),
        ),
      ),
      decorations: List<Decorations>.from(
        (map['decorations'] as List<dynamic>).map<Decorations>(
          (x) => Decorations.fromMap(x as Map<String, dynamic>),
        ),
      ),
      pollutionLevel: map['pollutionLevel'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pond.fromJson(String source) =>
      Pond.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pond(id: $id, name: $name, volume: $volume, photoUrl: $photoUrl, fish: $fish, plants: $plants, decorations: $decorations,  pollutionLevel: $pollutionLevel)';
  }

  @override
  bool operator ==(covariant Pond other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.volume == volume &&
        other.photoUrl == photoUrl &&
        listEquals(other.fish, fish) &&
        listEquals(other.tasks, tasks) &&
        listEquals(other.plants, plants) &&
        listEquals(other.decorations, decorations) &&
        other.pollutionLevel == pollutionLevel;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        volume.hashCode ^
        tasks.hashCode ^
        photoUrl.hashCode ^
        fish.hashCode ^
        plants.hashCode ^
        decorations.hashCode ^
        pollutionLevel.hashCode;
  }
}
