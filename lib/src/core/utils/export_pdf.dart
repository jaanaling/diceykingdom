import 'dart:typed_data';
import 'package:dicey_quests/src/games/bunker_player.dart';
import 'package:dicey_quests/src/games/dnd_character.dart';
import 'package:dicey_quests/src/games/mafia_player.dart';
import 'package:dicey_quests/src/games/pathfinder_character.dart';
import 'package:pdf/widgets.dart' as pw;

// Общий метод экспорта
Future<Uint8List> exportToPDF({
  required String title,
  required dynamic data, // Объект модели или список объектов
}) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              title,
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 10),
            if (data is PathfinderCharacter)
              ..._buildPathfinderCharacterPDF(data)
            else if (data is DnDCharacter)
              ..._buildDnDCharacterPDF(data)
            else if (data is BunkerPlayer)
              ..._buildBunkerPlayerPDF(data)
            else if (data is List<MafiaPlayer>)
              ..._buildMafiaPlayersPDF(data),
          ],
        );
      },
    ),
  );

  return pdf.save();
}

// Методы для построения PDF для каждой модели
List<pw.Widget> _buildPathfinderCharacterPDF(PathfinderCharacter character) {
  return [
    pw.Text('Name: ${character.name}'),
    pw.Text('Race: ${character.race}'),
    pw.Text('Class: ${character.characterClass}'),
    pw.Text('Strength: ${character.strength}'),
    pw.Text('Dexterity: ${character.dexterity}'),
    pw.Text('Constitution: ${character.constitution}'),
    pw.Text('Intelligence: ${character.intelligence}'),
    pw.Text('Wisdom: ${character.wisdom}'),
    pw.Text('Charisma: ${character.charisma}'),
    if (character.specialAbilities != null)
      pw.Text('Special Abilities: ${character.specialAbilities}'),
  ];
}

List<pw.Widget> _buildDnDCharacterPDF(DnDCharacter character) {
  return [
    pw.Text('Name: ${character.name}'),
    pw.Text('Race: ${character.race}'),
    pw.Text('Class: ${character.characterClass}'),
    pw.Text('Strength: ${character.strength}'),
    pw.Text('Dexterity: ${character.dexterity}'),
    pw.Text('Constitution: ${character.constitution}'),
    pw.Text('Intelligence: ${character.intelligence}'),
    pw.Text('Wisdom: ${character.wisdom}'),
    pw.Text('Charisma: ${character.charisma}'),
    if (character.weapon != null) pw.Text('Weapon: ${character.weapon}'),
    if (character.classAbilities != null)
      pw.Text('Class Abilities: ${character.classAbilities}'),
  ];
}

List<pw.Widget> _buildBunkerPlayerPDF(BunkerPlayer player) {
  return [
    pw.Text('Name: ${player.name}'),
    pw.Text('Age: ${player.age}'),
    pw.Text('Gender: ${player.gender}'),
    pw.Text('Profession: ${player.profession}'),
    pw.Text('Health Condition: ${player.healthCondition}'),
    pw.Text('Skill: ${player.skill}'),
    pw.Text('Item: ${player.item}'),
    pw.Text('Phobia: ${player.phobia}'),
    pw.Text('Hobby: ${player.hobby}'),
    pw.Text('Unique Trait: ${player.uniqueTrait}'),
  ];
}

List<pw.Widget> _buildMafiaPlayersPDF(List<MafiaPlayer> players) {
  return players.asMap().entries.map((entry) {
    final index = entry.key + 1;
    final player = entry.value;
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Player $index:',
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        ),
        pw.Text('Name: ${player.playerName}'),
        pw.Text('Role: ${player.role}'),
        pw.Text('Description: ${player.description}'),
        pw.SizedBox(height: 10),
      ],
    );
  }).toList();
}
