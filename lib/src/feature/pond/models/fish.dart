// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Fish {
  final String id;
  final String name;
  final String? imageUrl;
  final String size; // "small", "medium", "large"
  final bool isCompatible; // Совместимость с другими видами
  final double minOxygenLevel;
  final double maxOxygenLevel;
  final double minTemperature;
  final double maxTemperature;
  final List<String> recommendedFish;
  final String dietType; // "herbivore", "carnivore", "omnivore"
  final int activityLevel; // Уровень активности (1-10)
  final String color; // Цвет рыбы
  final String origin; // Регион происхождения
  final int lifespan; // Продолжительность жизни
  final bool needsShade; // Нужна ли рыбе тень
  final bool sensitiveToPollution; // Чувствительность к загрязнению
  final String swimmingZone; // "surface", "middle", "bottom" — где рыба предпочитает плавать
  final bool aggressive; // Агрессивность рыбы
  final bool needsOpenSpace; // Нужна ли рыбе открытая вода без растений и декораций
  final String groundPreference;
  Fish({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.size,
    required this.isCompatible,
    required this.minOxygenLevel,
    required this.maxOxygenLevel,
    required this.minTemperature,
    required this.maxTemperature,
    required this.recommendedFish,
    required this.dietType,
    required this.activityLevel,
    required this.color,
    required this.origin,
    required this.lifespan,
    required this.needsShade,
    required this.sensitiveToPollution,
    required this.swimmingZone,
    required this.aggressive,
    required this.needsOpenSpace,
    required this.groundPreference,
  });



  Fish copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? size,
    bool? isCompatible,
    double? minOxygenLevel,
    double? maxOxygenLevel,
    double? minTemperature,
    double? maxTemperature,
    List<String>? recommendedFish,
    String? dietType,
    int? activityLevel,
    String? color,
    String? origin,
    int? lifespan,
    bool? needsShade,
    bool? sensitiveToPollution,
    String? swimmingZone,
    bool? aggressive,
    bool? needsOpenSpace,
    String? groundPreference,
  }) {
    return Fish(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      size: size ?? this.size,
      isCompatible: isCompatible ?? this.isCompatible,
      minOxygenLevel: minOxygenLevel ?? this.minOxygenLevel,
      maxOxygenLevel: maxOxygenLevel ?? this.maxOxygenLevel,
      minTemperature: minTemperature ?? this.minTemperature,
      maxTemperature: maxTemperature ?? this.maxTemperature,
      recommendedFish: recommendedFish ?? this.recommendedFish,
      dietType: dietType ?? this.dietType,
      activityLevel: activityLevel ?? this.activityLevel,
      color: color ?? this.color,
      origin: origin ?? this.origin,
      lifespan: lifespan ?? this.lifespan,
      needsShade: needsShade ?? this.needsShade,
      sensitiveToPollution: sensitiveToPollution ?? this.sensitiveToPollution,
      swimmingZone: swimmingZone ?? this.swimmingZone,
      aggressive: aggressive ?? this.aggressive,
      needsOpenSpace: needsOpenSpace ?? this.needsOpenSpace,
      groundPreference: groundPreference ?? this.groundPreference,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'size': size,
      'isCompatible': isCompatible,
      'minOxygenLevel': minOxygenLevel,
      'maxOxygenLevel': maxOxygenLevel,
      'minTemperature': minTemperature,
      'maxTemperature': maxTemperature,
      'recommendedFish': recommendedFish,
      'dietType': dietType,
      'activityLevel': activityLevel,
      'color': color,
      'origin': origin,
      'lifespan': lifespan,
      'needsShade': needsShade,
      'sensitiveToPollution': sensitiveToPollution,
      'swimmingZone': swimmingZone,
      'aggressive': aggressive,
      'needsOpenSpace': needsOpenSpace,
      'groundPreference': groundPreference,
    };
  }

  factory Fish.fromMap(Map<String, dynamic> map) {
    return Fish(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      size: map['size'] as String,
      isCompatible: map['isCompatible'] as bool,
      minOxygenLevel: map['minOxygenLevel'] as double,
      maxOxygenLevel: map['maxOxygenLevel'] as double,
      minTemperature: map['minTemperature'] as double,
      maxTemperature: map['maxTemperature'] as double,
      recommendedFish: List<String>.from(map['recommendedFish'] as List<dynamic>),
      dietType: map['dietType'] as String,
      activityLevel: map['activityLevel'] as int,
      color: map['color'] as String,
      origin: map['origin'] as String,
      lifespan: map['lifespan'] as int,
      needsShade: map['needsShade'] as bool,
      sensitiveToPollution: map['sensitiveToPollution'] as bool,
      swimmingZone: map['swimmingZone'] as String,
      aggressive: map['aggressive'] as bool,
      needsOpenSpace: map['needsOpenSpace'] as bool,
      groundPreference: map['groundPreference'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Fish.fromJson(String source) => Fish.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Fish(id: $id, name: $name, imageUrl: $imageUrl, size: $size, isCompatible: $isCompatible, minOxygenLevel: $minOxygenLevel, maxOxygenLevel: $maxOxygenLevel, minTemperature: $minTemperature, maxTemperature: $maxTemperature, recommendedFish: $recommendedFish, dietType: $dietType, activityLevel: $activityLevel, color: $color, origin: $origin, lifespan: $lifespan, needsShade: $needsShade, sensitiveToPollution: $sensitiveToPollution, swimmingZone: $swimmingZone, aggressive: $aggressive, needsOpenSpace: $needsOpenSpace, groundPreference: $groundPreference)';
  }

  @override
  bool operator ==(covariant Fish other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.imageUrl == imageUrl &&
      other.size == size &&
      other.isCompatible == isCompatible &&
      other.minOxygenLevel == minOxygenLevel &&
      other.maxOxygenLevel == maxOxygenLevel &&
      other.minTemperature == minTemperature &&
      other.maxTemperature == maxTemperature &&
      listEquals(other.recommendedFish, recommendedFish) &&
      other.dietType == dietType &&
      other.activityLevel == activityLevel &&
      other.color == color &&
      other.origin == origin &&
      other.lifespan == lifespan &&
      other.needsShade == needsShade &&
      other.sensitiveToPollution == sensitiveToPollution &&
      other.swimmingZone == swimmingZone &&
      other.aggressive == aggressive &&
      other.needsOpenSpace == needsOpenSpace &&
      other.groundPreference == groundPreference;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      imageUrl.hashCode ^
      size.hashCode ^
      isCompatible.hashCode ^
      minOxygenLevel.hashCode ^
      maxOxygenLevel.hashCode ^
      minTemperature.hashCode ^
      maxTemperature.hashCode ^
      recommendedFish.hashCode ^
      dietType.hashCode ^
      activityLevel.hashCode ^
      color.hashCode ^
      origin.hashCode ^
      lifespan.hashCode ^
      needsShade.hashCode ^
      sensitiveToPollution.hashCode ^
      swimmingZone.hashCode ^
      aggressive.hashCode ^
      needsOpenSpace.hashCode ^
      groundPreference.hashCode;
  }
}
