// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Decorations {
  final String id;
  final String name;
  final String? imageUrl;
  final String size; // "small", "medium", "large"
  final String material; // Материал: "stone", "wood", "plastic"
  final bool promotesAlgaeGrowth;
  final bool safeForFish;
  final String aestheticStyle;
  final bool floats;
  final bool interactive;
  final String maintenanceRequirement; // Уровень ухода: "low", "medium", "high"
  final bool blocksSwimming; // Блокирует ли плавание рыб
  final bool supportsFishHiding; // Обеспечивает ли укрытия для рыб
  final bool fragile; // Легко ли ломается
  final bool pollutantSource; // Может ли быть источником загрязнения воды

  Decorations({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.size,
    required this.material,
    required this.promotesAlgaeGrowth,
    required this.safeForFish,
    required this.aestheticStyle,
    required this.floats,
    required this.interactive,
    required this.maintenanceRequirement,
    required this.blocksSwimming,
    required this.supportsFishHiding,
    required this.fragile,
    required this.pollutantSource,
  });

  Decorations copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? size,
    String? material,
    bool? promotesAlgaeGrowth,
    bool? safeForFish,
    String? aestheticStyle,
    bool? floats,
    bool? interactive,
    String? maintenanceRequirement,
    bool? blocksSwimming,
    bool? supportsFishHiding,
    bool? fragile,
    bool? pollutantSource,
  }) {
    return Decorations(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      size: size ?? this.size,
      material: material ?? this.material,
      promotesAlgaeGrowth: promotesAlgaeGrowth ?? this.promotesAlgaeGrowth,
      safeForFish: safeForFish ?? this.safeForFish,
      aestheticStyle: aestheticStyle ?? this.aestheticStyle,
      floats: floats ?? this.floats,
      interactive: interactive ?? this.interactive,
      maintenanceRequirement: maintenanceRequirement ?? this.maintenanceRequirement,
      blocksSwimming: blocksSwimming ?? this.blocksSwimming,
      supportsFishHiding: supportsFishHiding ?? this.supportsFishHiding,
      fragile: fragile ?? this.fragile,
      pollutantSource: pollutantSource ?? this.pollutantSource,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'size': size,
      'material': material,
      'promotesAlgaeGrowth': promotesAlgaeGrowth,
      'safeForFish': safeForFish,
      'aestheticStyle': aestheticStyle,
      'floats': floats,
      'interactive': interactive,
      'maintenanceRequirement': maintenanceRequirement,
      'blocksSwimming': blocksSwimming,
      'supportsFishHiding': supportsFishHiding,
      'fragile': fragile,
      'pollutantSource': pollutantSource,
    };
  }

  factory Decorations.fromMap(Map<String, dynamic> map) {
    return Decorations(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      size: map['size'] as String,
      material: map['material'] as String,
      promotesAlgaeGrowth: map['promotesAlgaeGrowth'] as bool,
      safeForFish: map['safeForFish'] as bool,
      aestheticStyle: map['aestheticStyle'] as String,
      floats: map['floats'] as bool,
      interactive: map['interactive'] as bool,
      maintenanceRequirement: map['maintenanceRequirement'] as String,
      blocksSwimming: map['blocksSwimming'] as bool,
      supportsFishHiding: map['supportsFishHiding'] as bool,
      fragile: map['fragile'] as bool,
      pollutantSource: map['pollutantSource'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Decorations.fromJson(String source) => Decorations.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Decorations(id: $id, name: $name, imageUrl: $imageUrl, size: $size, material: $material, promotesAlgaeGrowth: $promotesAlgaeGrowth, safeForFish: $safeForFish, aestheticStyle: $aestheticStyle, floats: $floats, interactive: $interactive, maintenanceRequirement: $maintenanceRequirement, blocksSwimming: $blocksSwimming, supportsFishHiding: $supportsFishHiding, fragile: $fragile, pollutantSource: $pollutantSource)';
  }

  @override
  bool operator ==(covariant Decorations other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.imageUrl == imageUrl &&
      other.size == size &&
      other.material == material &&
      other.promotesAlgaeGrowth == promotesAlgaeGrowth &&
      other.safeForFish == safeForFish &&
      other.aestheticStyle == aestheticStyle &&
      other.floats == floats &&
      other.interactive == interactive &&
      other.maintenanceRequirement == maintenanceRequirement &&
      other.blocksSwimming == blocksSwimming &&
      other.supportsFishHiding == supportsFishHiding &&
      other.fragile == fragile &&
      other.pollutantSource == pollutantSource;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      imageUrl.hashCode ^
      size.hashCode ^
      material.hashCode ^
      promotesAlgaeGrowth.hashCode ^
      safeForFish.hashCode ^
      aestheticStyle.hashCode ^
      floats.hashCode ^
      interactive.hashCode ^
      maintenanceRequirement.hashCode ^
      blocksSwimming.hashCode ^
      supportsFishHiding.hashCode ^
      fragile.hashCode ^
      pollutantSource.hashCode;
  }
}
