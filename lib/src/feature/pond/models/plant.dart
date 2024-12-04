// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Plant {
  final String id;
  final String name;
  final String? imageUrl;
  final String size; // "small", "medium", "large"
  final bool providesOxygen;
  final double oxygenOutput;
  final double minTemperature;
  final double maxTemperature;
  final bool isRecommended;
  final String description;
  final String growthRate; // "slow", "medium", "fast"
  final String lightRequirement; // "low", "medium", "high"
  final double waterPurificationRate;
  final bool invasiveSpecies;
  final String bloomingSeason;
  final bool providesShade;
  final bool supportsFishHiding; // Обеспечивает ли место для укрытия рыб
  final double
      nutrientAbsorptionRate; // Скорость поглощения питательных веществ из воды
  final String
      rootType; // Тип корневой системы: "floating", "rooted", "substrate"
  final bool sensitiveToPollution; // Чувствительность к загрязнению воды
  final String groundPreference;
  Plant({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.size,
    required this.providesOxygen,
    required this.oxygenOutput,
    required this.minTemperature,
    required this.maxTemperature,
    required this.isRecommended,
    required this.description,
    required this.growthRate,
    required this.lightRequirement,
    required this.waterPurificationRate,
    required this.invasiveSpecies,
    required this.bloomingSeason,
    required this.providesShade,
    required this.supportsFishHiding,
    required this.nutrientAbsorptionRate,
    required this.rootType,
    required this.sensitiveToPollution,
    required this.groundPreference,
  });

  Plant copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? size,
    bool? providesOxygen,
    double? oxygenOutput,
    double? minTemperature,
    double? maxTemperature,
    bool? isRecommended,
    String? description,
    String? growthRate,
    String? lightRequirement,
    double? waterPurificationRate,
    bool? invasiveSpecies,
    String? bloomingSeason,
    bool? providesShade,
    bool? supportsFishHiding,
    double? nutrientAbsorptionRate,
    String? rootType,
    bool? sensitiveToPollution,
    String? groundPreference,
  }) {
    return Plant(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      size: size ?? this.size,
      providesOxygen: providesOxygen ?? this.providesOxygen,
      oxygenOutput: oxygenOutput ?? this.oxygenOutput,
      minTemperature: minTemperature ?? this.minTemperature,
      maxTemperature: maxTemperature ?? this.maxTemperature,
      isRecommended: isRecommended ?? this.isRecommended,
      description: description ?? this.description,
      growthRate: growthRate ?? this.growthRate,
      lightRequirement: lightRequirement ?? this.lightRequirement,
      waterPurificationRate:
          waterPurificationRate ?? this.waterPurificationRate,
      invasiveSpecies: invasiveSpecies ?? this.invasiveSpecies,
      bloomingSeason: bloomingSeason ?? this.bloomingSeason,
      providesShade: providesShade ?? this.providesShade,
      supportsFishHiding: supportsFishHiding ?? this.supportsFishHiding,
      nutrientAbsorptionRate:
          nutrientAbsorptionRate ?? this.nutrientAbsorptionRate,
      rootType: rootType ?? this.rootType,
      sensitiveToPollution: sensitiveToPollution ?? this.sensitiveToPollution,
      groundPreference: groundPreference ?? this.groundPreference,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'size': size,
      'providesOxygen': providesOxygen,
      'oxygenOutput': oxygenOutput,
      'minTemperature': minTemperature,
      'maxTemperature': maxTemperature,
      'isRecommended': isRecommended,
      'description': description,
      'growthRate': growthRate,
      'lightRequirement': lightRequirement,
      'waterPurificationRate': waterPurificationRate,
      'invasiveSpecies': invasiveSpecies,
      'bloomingSeason': bloomingSeason,
      'providesShade': providesShade,
      'supportsFishHiding': supportsFishHiding,
      'nutrientAbsorptionRate': nutrientAbsorptionRate,
      'rootType': rootType,
      'sensitiveToPollution': sensitiveToPollution,
      'groundPreference': groundPreference,
    };
  }

  factory Plant.fromMap(Map<String, dynamic> map) {
    return Plant(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      size: map['size'] as String,
      providesOxygen: map['providesOxygen'] as bool,
      oxygenOutput: map['oxygenOutput'] as double,
      minTemperature: map['minTemperature'] as double,
      maxTemperature: map['maxTemperature'] as double,
      isRecommended: map['isRecommended'] as bool,
      description: map['description'] as String,
      growthRate: map['growthRate'] as String,
      lightRequirement: map['lightRequirement'] as String,
      waterPurificationRate: map['waterPurificationRate'] as double,
      invasiveSpecies: map['invasiveSpecies'] as bool,
      bloomingSeason: map['bloomingSeason'] as String,
      providesShade: map['providesShade'] as bool,
      supportsFishHiding: map['supportsFishHiding'] as bool,
      nutrientAbsorptionRate: map['nutrientAbsorptionRate'] as double,
      rootType: map['rootType'] as String,
      sensitiveToPollution: map['sensitiveToPollution'] as bool,
      groundPreference: map['groundPreference'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Plant.fromJson(String source) =>
      Plant.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Plant(id: $id, name: $name, imageUrl: $imageUrl, size: $size, providesOxygen: $providesOxygen, oxygenOutput: $oxygenOutput, minTemperature: $minTemperature, maxTemperature: $maxTemperature, isRecommended: $isRecommended, description: $description, growthRate: $growthRate, lightRequirement: $lightRequirement, waterPurificationRate: $waterPurificationRate, invasiveSpecies: $invasiveSpecies, bloomingSeason: $bloomingSeason, providesShade: $providesShade, supportsFishHiding: $supportsFishHiding, nutrientAbsorptionRate: $nutrientAbsorptionRate, rootType: $rootType, sensitiveToPollution: $sensitiveToPollution, groundPreference: $groundPreference)';
  }

  @override
  bool operator ==(covariant Plant other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        other.size == size &&
        other.providesOxygen == providesOxygen &&
        other.oxygenOutput == oxygenOutput &&
        other.minTemperature == minTemperature &&
        other.maxTemperature == maxTemperature &&
        other.isRecommended == isRecommended &&
        other.description == description &&
        other.growthRate == growthRate &&
        other.lightRequirement == lightRequirement &&
        other.waterPurificationRate == waterPurificationRate &&
        other.invasiveSpecies == invasiveSpecies &&
        other.bloomingSeason == bloomingSeason &&
        other.providesShade == providesShade &&
        other.supportsFishHiding == supportsFishHiding &&
        other.nutrientAbsorptionRate == nutrientAbsorptionRate &&
        other.rootType == rootType &&
        other.sensitiveToPollution == sensitiveToPollution &&
        other.groundPreference == groundPreference;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        imageUrl.hashCode ^
        size.hashCode ^
        providesOxygen.hashCode ^
        oxygenOutput.hashCode ^
        minTemperature.hashCode ^
        maxTemperature.hashCode ^
        isRecommended.hashCode ^
        description.hashCode ^
        growthRate.hashCode ^
        lightRequirement.hashCode ^
        waterPurificationRate.hashCode ^
        invasiveSpecies.hashCode ^
        bloomingSeason.hashCode ^
        providesShade.hashCode ^
        supportsFishHiding.hashCode ^
        nutrientAbsorptionRate.hashCode ^
        rootType.hashCode ^
        sensitiveToPollution.hashCode ^
        groundPreference.hashCode;
  }
}
