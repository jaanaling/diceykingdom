import 'dart:math';
import 'dart:typed_data';
import 'package:dicey_quests/routes/route_value.dart';
import 'package:dicey_quests/src/core/utils/export_pdf.dart';
import 'package:dicey_quests/src/core/utils/log.dart';
import 'package:dicey_quests/src/feature/game/bloc/game_bloc.dart';
import 'package:dicey_quests/src/feature/quests/presentation/show_card_dialog.dart';
import 'package:dicey_quests/src/games/bunker_generator.dart';
import 'package:dicey_quests/src/games/bunker_player.dart';
import 'package:dicey_quests/src/games/dnd_character.dart';
import 'package:dicey_quests/src/games/dnd_generator.dart';
import 'package:dicey_quests/src/games/field.dart';
import 'package:dicey_quests/src/games/mafia_generator.dart';
import 'package:dicey_quests/src/games/mafia_player.dart';
import 'package:dicey_quests/src/games/pathfinder_character.dart';
import 'package:dicey_quests/src/games/pathfinder_generator.dart';
import 'package:dicey_quests/ui_kit/app_button/app_button.dart';
import 'package:dicey_quests/ui_kit/app_card.dart';
import 'package:dicey_quests/ui_kit/number_field.dart';
import 'package:dicey_quests/ui_kit/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:printing/printing.dart';

enum GameType { bunker, dnd, pathfinder, mafia }

class GeneratorScreen extends StatefulWidget {
  const GeneratorScreen({super.key});

  @override
  State<GeneratorScreen> createState() => _GeneratorScreenState();
}

class _GeneratorScreenState extends State<GeneratorScreen> {
  Map<String, dynamic> selections = {};
  final _formKey = GlobalKey<FormState>();
  GameType selectedGame = GameType.bunker;

  List<Field> getFieldsForSelectedGame() {
    switch (selectedGame) {
      case GameType.bunker:
        return BunkerGenerator.getFieldsToDisplay(selections);
      case GameType.dnd:
        return DnDGenerator.getFieldsToDisplay(selections);
      case GameType.pathfinder:
        return PathfinderGenerator.getFieldsToDisplay(selections);
      case GameType.mafia:
        return getMafiaFieldsToDisplay();
    }
  }

  List<Field> getMafiaFieldsToDisplay() {
    return [
      Field(
        name: 'Player Count',
        type: FieldType.number,
        minValue: 3,
        maxValue: 20,
      ),
    ];
  }

  void generateRandomForSelectedGame() {
    switch (selectedGame) {
      case GameType.bunker:
        final player = BunkerGenerator.generatePlayer();
        selections = {
          'Name': player.name,
          'Age': player.age,
          'Gender': player.gender,
          'Profession': player.profession,
          'Health Condition': player.healthCondition,
          'Skill': player.skill,
          'Item': player.item,
          'Phobia': player.phobia,
          'Hobby': player.hobby,
          'Unique Trait': player.uniqueTrait,
        };
      case GameType.dnd:
        final character = DnDGenerator.generateCharacter();
        selections = {
          'Name': character.name,
          'Race': character.race,
          'Class': character.characterClass,
          'Strength': character.strength,
          'Dexterity': character.dexterity,
          'Constitution': character.constitution,
          'Intelligence': character.intelligence,
          'Wisdom': character.wisdom,
          'Charisma': character.charisma,
          if (character.weapon != null) 'Weapon': character.weapon,
          if (character.classAbilities != null)
            'Class Abilities': character.classAbilities,
        };
      case GameType.pathfinder:
        final character = PathfinderGenerator.generateCharacter();
        selections = {
          'Name': character.name,
          'Race': character.race,
          'Class': character.characterClass,
          'Strength': character.strength,
          'Dexterity': character.dexterity,
          'Constitution': character.constitution,
          'Intelligence': character.intelligence,
          'Wisdom': character.wisdom,
          'Charisma': character.charisma,
          if (character.specialAbilities != null)
            'Special Abilities': character.specialAbilities,
        };
      case GameType.mafia:
        int playerCount = 3 + (Random().nextInt(18)); // от 3 до 20
        selections = {
          'Player Count': playerCount,
        };
    }

    setState(() {});
  }

  void showCustomDialog({
    required BuildContext context,
    required String title,
    required String content,
    required List<Widget> actions,
  }) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: AppCard(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: 'Jellee',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: SingleChildScrollView(
                    child: Text(
                      content,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Jellee',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                ...actions,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitForm() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    switch (selectedGame) {
      case GameType.bunker:
        if (selections.containsKey('Profession')) {
          final player = BunkerGenerator.createPlayerFromData(selections);

          showCustomDialog(
            context: context,
            title: 'Bunker Player Created',
            content: 'Name: ${player.name}\n'
                'Age: ${player.age}\n'
                'Gender: ${player.gender}\n'
                'Profession: ${player.profession}\n'
                'Health Condition: ${player.healthCondition}\n'
                'Skill: ${player.skill}\n'
                'Item: ${player.item}\n'
                'Phobia: ${player.phobia}\n'
                'Hobby: ${player.hobby}\n'
                'Unique Trait: ${player.uniqueTrait}',
            actions: [
              AppButton(
                width: double.infinity,
                color: ButtonColors.darkOrange,
                onPressed: () async {
                  final pdfData = await exportToPDF(
                    title: 'Bunker Player',
                    data: player,
                  );
                  await Printing.layoutPdf(onLayout: (format) => pdfData);
                },
                widget: Text(
                  'Export to PDF',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Jellee',
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              AppButton(
                width: double.infinity,
                color: ButtonColors.orange,
                onPressed: () {
                  context.read<GameBloc>().add(SaveProfile(player));
                  GoRouter.of(context).pop();
                },
                widget: Text(
                  'Save Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Jellee',
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              AppButton(
                width: double.infinity,
                color: ButtonColors.green,
                onPressed: () => GoRouter.of(context).pop(),
                widget: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Jellee',
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        } else {
          setState(() {});
        }

      case GameType.dnd:
        if (selections.containsKey('Strength')) {
          final character = DnDGenerator.createCharacterFromData(selections);

          showCustomDialog(
            context: context,
            title: 'DnD Character Created',
            content: 'Name: ${character.name}\n'
                'Race: ${character.race}\n'
                'Class: ${character.characterClass}\n'
                'Str: ${character.strength}, Dex: ${character.dexterity}, Con: ${character.constitution}\n'
                'Int: ${character.intelligence}, Wis: ${character.wisdom}, Cha: ${character.charisma}\n'
                'Weapon: ${character.weapon}\n'
                'Class Abilities: ${character.classAbilities}',
            actions: [
              AppButton(
                width: double.infinity,
                color: ButtonColors.darkOrange,
                onPressed: () async {
                  final pdfData = await exportToPDF(
                    title: 'DnD Character Sheet',
                    data: character,
                  );
                  await Printing.layoutPdf(onLayout: (format) => pdfData);
                },
                widget: Text(
                  'Export to PDF',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Jellee',
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              AppButton(
                width: double.infinity,
                color: ButtonColors.yellow,
                onPressed: () {
                  context.read<GameBloc>().add(SaveProfile(character));
                  GoRouter.of(context).pop();
                },
                widget: Text(
                  'Save Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Jellee',
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              AppButton(
                width: double.infinity,
                color: ButtonColors.green,
                onPressed: () => GoRouter.of(context).pop(),
                widget: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Jellee',
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        } else {
          setState(() {});
        }

      case GameType.pathfinder:
        if (selections.containsKey('Strength')) {
          final character =
              PathfinderGenerator.createCharacterFromData(selections);

          showCustomDialog(
            context: context,
            title: 'Pathfinder Character Created',
            content: 'Name: ${character.name}\n'
                'Race: ${character.race}\n'
                'Class: ${character.characterClass}\n'
                'Str: ${character.strength}, Dex: ${character.dexterity}, Con: ${character.constitution}\n'
                'Int: ${character.intelligence}, Wis: ${character.wisdom}, Cha: ${character.charisma}\n'
                'Special Abilities: ${character.specialAbilities ?? "None"}',
            actions: [
              AppButton(
                width: double.infinity,
                color: ButtonColors.darkOrange,
                onPressed: () async {
                  final pdfData = await exportToPDF(
                    title: 'Pathfinder Character Sheet',
                    data: character,
                  );
                  await Printing.layoutPdf(onLayout: (format) => pdfData);
                },
                widget: Text(
                  'Export to PDF',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Jellee',
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              AppButton(
                width: double.infinity,
                color: ButtonColors.yellow,
                onPressed: () {
                  context.read<GameBloc>().add(SaveProfile(character));
                  GoRouter.of(context).pop();
                },
                widget: Text(
                  'Save Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Jellee',
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              AppButton(
                width: double.infinity,
                color: ButtonColors.green,
                onPressed: () => GoRouter.of(context).pop(),
                widget: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Jellee',
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        } else {
          setState(() {});
        }

      case GameType.mafia:
        if (selections.containsKey('Player Count')) {
          final mafias =
              MafiaGenerator.generateRoles(selections['Player Count'] as int);
          StringBuffer sb = StringBuffer();
          for (var p in mafias.players) {
            sb.writeln('${p.playerName}: ${p.role} - ${p.description}');
          }

          showCustomDialog(
            context: context,
            title: 'Mafia Roles',
            content: sb.toString(),
            actions: [
              AppButton(
                width: double.infinity,
                color: ButtonColors.darkOrange,
                onPressed: () async {
                  final pdfData = await exportToPDF(
                    title: 'Mafia Roles',
                    data: mafias.players,
                  );
                  await Printing.layoutPdf(onLayout: (format) => pdfData);
                },
                widget: Text('Export to PDF'),
              ),
              AppButton(
                width: double.infinity,
                color: ButtonColors.yellow,
                onPressed: () {
                  context.read<GameBloc>().add(SaveProfile(mafias));
                  GoRouter.of(context).pop();
                },
                widget: Text(
                  'Save Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Jellee',
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              AppButton(
                width: double.infinity,
                color: ButtonColors.green,
                onPressed: () => GoRouter.of(context).pop(),
                widget: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Jellee',
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        } else {
          setState(() {});
        }
    }
  }

  // Метод для предзаполнения полей на основе возвращённого из шаблонов профиля
  void prefillFromProfile(dynamic profile) {
    if (profile is BunkerPlayer) {
      selections = {
        'Name': profile.name,
        'Age': profile.age,
        'Gender': profile.gender,
        'Profession': profile.profession,
        'Health Condition': profile.healthCondition,
        'Skill': profile.skill,
        'Item': profile.item,
        'Phobia': profile.phobia,
        'Hobby': profile.hobby,
        'Unique Trait': profile.uniqueTrait,
      };
      selectedGame = GameType.bunker;
    } else if (profile is DnDCharacter) {
      selections = {
        'Name': profile.name,
        'Race': profile.race,
        'Class': profile.characterClass,
        'Strength': profile.strength,
        'Dexterity': profile.dexterity,
        'Constitution': profile.constitution,
        'Intelligence': profile.intelligence,
        'Wisdom': profile.wisdom,
        'Charisma': profile.charisma,
        if (profile.weapon != null) 'Weapon': profile.weapon,
        if (profile.classAbilities != null)
          'Class Abilities': profile.classAbilities,
      };
      selectedGame = GameType.dnd;
    } else if (profile is PathfinderCharacter) {
      selections = {
        'Name': profile.name,
        'Race': profile.race,
        'Class': profile.characterClass,
        'Strength': profile.strength,
        'Dexterity': profile.dexterity,
        'Constitution': profile.constitution,
        'Intelligence': profile.intelligence,
        'Wisdom': profile.wisdom,
        'Charisma': profile.charisma,
        if (profile.specialAbilities != null)
          'Special Abilities': profile.specialAbilities,
      };
      selectedGame = GameType.pathfinder;
    } else if (profile is Mafias) {
      selections = {
        'Player Count': profile.players.length,
      };
      selectedGame = GameType.mafia;
    }
    setState(() {});
  }

  Widget buildField(Field field) {
    TextEditingController controller =
        TextEditingController(text: selections[field.name]?.toString() ?? '');

    switch (field.type) {
      case FieldType.text:
        return AppTextField(
          height: 70,
          topText: field.name,
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter ${field.name}';
            }
            return null;
          },
          onChanged: (value) {
            selections[field.name] = value;
          },
        );
      case FieldType.number:
        return NumberField(
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter ${field.name}';
            }
            final numValue = int.tryParse(value);
            if (numValue == null ||
                (field.minValue != null && numValue < field.minValue!) ||
                (field.maxValue != null && numValue > field.maxValue!)) {
              return 'Please enter a valid number for ${field.name}';
            }
            return null;
          },
          onSaved: (value) {
            selections[field.name] = int.parse(value!);
          },
          placeholder: field.name,
          onAdd: () {
            setState(() {
              if (selections[field.name] != null) {
                selections[field.name]++;
              } else {
                selections[field.name] = 1;
              }
            });
          },
          onRemove: () {
            setState(() {
              if (selections[field.name] != null) {
                selections[field.name]--;
              }
            });
          },
        );
      case FieldType.dropdown:
        return AppButton(
          width: double.infinity,
          color: ButtonColors.pink,
          widget: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              (selections[field.name] as String?) ?? field.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Jellee',
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (_) => SizedBox(
                height: 250,
                child: CupertinoPicker(
                  backgroundColor: Colors.white,
                  itemExtent: 32,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      selections[field.name] = field.options![index];
                    });
                  },
                  children:
                      field.options!.map((option) => Text(option)).toList(),
                ),
              ),
            );
          },
        );

      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            if (state is GameLoaded) {
              List<Field> fields = getFieldsForSelectedGame();
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    AppButton(
                      width: double.infinity,
                      color: ButtonColors.orange,
                      widget: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          GameType.values[selectedGame.index].name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontFamily: 'Jellee',
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (_) => SizedBox(
                            height: 250,
                            child: CupertinoPicker(
                              backgroundColor: Colors.white,
                              itemExtent: 32,
                              onSelectedItemChanged: (index) {
                                setState(() {
                                  selectedGame = GameType.values[index];
                                  selections.clear();
                                });
                              },
                              children: GameType.values
                                  .map((option) => Text(option.name))
                                  .toList(),
                            ),
                          ),
                        );
                      },
                    ),
                    const Gap(16),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          children: [
                            ...fields.map(
                              (f) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                child: buildField(f),
                              ),
                            ),
                            const SizedBox(height: 16),
                            AppButton(
                              width: MediaQuery.of(context).size.width * 0.25,
                              color: ButtonColors.white,
                              onPressed: submitForm,
                              widget: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Jellee',
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppButton(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  color: ButtonColors.green,
                                  onPressed: generateRandomForSelectedGame,
                                  widget: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Generate',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Jellee',
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                AppButton(
                                  color: ButtonColors.orange,
                                  onPressed: () async {
                                    // Переходим на экран шаблонов и ждём выбранный профиль
                                    final result = await showGeneratorDialog(
                                      context,
                                      state.characterProfiles,
                                    );
                                    if (!mounted) {
                                      logger.d("widget not mounted");
                                    } // проверяем, что виджет всё ещё в дереве

                                    if (result != null) {
                                      logger.d(result);
                                      WidgetsBinding.instance
                                          .addPostFrameCallback(
                                        (_) {
                                          setState(() {
                                            prefillFromProfile(result);
                                          });
                                        },
                                      );
                                    } else {
                                      logger.d("result is null");
                                    }
                                  },
                                  widget: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Templates',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Jellee',
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(140),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is GameLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is GameError) {
              return Center(child: Text(state.message));
            }

            return const Placeholder();
          },
        ),
      ),
    );
  }
}
