import 'dart:math';
import 'dart:typed_data';

import 'package:dicey_quests/src/core/utils/export_pdf.dart';
import 'package:dicey_quests/src/games/dnd_generator.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

enum FieldType { text, dropdown, number, slider }

// Описание поля
class Field {
  final String name;
  final FieldType type;
  final List<String>? options; // Для выпадающих списков
  final num? minValue; // Для числовых и слайдеров
  final num? maxValue;

  Field({
    required this.name,
    required this.type,
    this.options,
    this.minValue,
    this.maxValue,
  });
}

// ---------------------- Utility Functions ----------------------

T randomChoice<T>(List<T> options) {
  final random = Random();
  return options[random.nextInt(options.length)];
}

num randomValue(num min, num max) {
  final random = Random();
  return min + random.nextDouble() * (max - min);
}
