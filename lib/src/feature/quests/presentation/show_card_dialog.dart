import 'dart:ui' as ui;
import 'package:dicey_quests/routes/go_router_config.dart';
import 'package:dicey_quests/src/feature/game/bloc/game_bloc.dart';
import 'package:dicey_quests/src/feature/game/model/challenge.dart';
import 'package:dicey_quests/src/feature/game/model/game.dart';
import 'package:dicey_quests/src/games/bunker_player.dart';
import 'package:dicey_quests/src/games/dnd_character.dart';
import 'package:dicey_quests/src/games/mafia_player.dart';
import 'package:dicey_quests/src/games/pathfinder_character.dart';
import 'package:dicey_quests/src/games/player.dart';
import 'package:dicey_quests/ui_kit/app_button/app_button.dart';
import 'package:dicey_quests/ui_kit/app_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

Future<CharacterProfile?> showGeneratorDialog(
  BuildContext context,
  List<CharacterProfile> profiles,
) async {
  CharacterProfile? choosedProfile;
  CharacterProfile? chooseProfile;
  final controller = FlipCardController();
  String title = 'Profile Details';
  String content = '';
  await showAdaptiveDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: StatefulBuilder(
          builder: (context, setState) {
            return FlipCard(
              controller: controller,
              rotateSide: RotateSide.left,
              animationDuration: Duration(milliseconds: 600),
              axis: FlipAxis.vertical,
              backWidget: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 700,
                  child: CardBack(child: Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontFamily: 'Jellee',
                                fontWeight: FontWeight.w700,
                              )),
                          SizedBox(
                            height: 500,
                            child: SingleChildScrollView(
                              child: Text(content,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Jellee',
                                    fontWeight: FontWeight.w700,
                                  )),
                            ),
                          ),
                          Spacer(),
                          if (title != "Mafia Players")
                            AppButton(
                              width: double.infinity,
                              color: ButtonColors.green,
                              onPressed: () {
                                chooseProfile = choosedProfile;
                                Navigator.of(context).pop(chooseProfile);
                              },
                              widget: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Use as template',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'Jellee',
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                            ),
                          AppButton(
                            width: double.infinity,
                            color: ButtonColors.red,
                            onPressed: () => controller.flipcard(),
                            widget: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Back',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Jellee',
                                    fontWeight: FontWeight.w700,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    );
                  })),
                ),
              ),
              frontWidget: AppCard(
                child: Column(
                  children: [
                    Expanded(
                      child: profiles.length == 0
                          ? Center(child: Text("No saved profiles yet"))
                          : ListView.separated(
                              itemCount: profiles.length,
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                              separatorBuilder: (_, __) => Gap(6),
                              itemBuilder: (context, index) {
                                final profile = profiles[index];

                                if (profile is BunkerPlayer) {
                                  final player = profile;
                                  return AppButton(
                                    color: ButtonColors.yellow,
                                    width: double.infinity,
                                    onPressed: () {
                                      choosedProfile = profile;

                                      title = 'Bunker Player';
                                      content = 'Name: ${profile.name}\n'
                                          'Age: ${profile.age}\n'
                                          'Gender: ${profile.gender}\n'
                                          'Profession: ${profile.profession}\n'
                                          'Health Condition: ${profile.healthCondition}\n'
                                          'Skill: ${profile.skill}\n'
                                          'Item: ${profile.item}\n'
                                          'Phobia: ${profile.phobia}\n'
                                          'Hobby: ${profile.hobby}\n'
                                          'Unique Trait: ${profile.uniqueTrait}';
                                      setState(() {});
                                      controller.flipcard();
                                    },
                                    widget: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Bunker: " + player.name,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'Jellee',
                                            fontWeight: FontWeight.w700,
                                          )),
                                    ),
                                  );
                                }

                                if (profile is Mafias) {
                                  final mafias = profile;
                                  return AppButton(
                                    color: ButtonColors.darkOrange,
                                    width: double.infinity,
                                    onPressed: () {
                                      choosedProfile = profile;

                                      title = 'Mafia Players';
                                      final buffer = StringBuffer();
                                      for (int i = 0;
                                          i < profile.players.length;
                                          i++) {
                                        final player = profile.players[i];
                                        buffer.writeln(
                                            'Player ${i + 1}: ${player.playerName} - ${player.role}\n${player.description}\n');
                                      }
                                      content = buffer.toString();
                                      setState(() {});
                                      controller.flipcard();
                                    },
                                    widget: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          'Mafias: ${mafias.players.length} players',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'Jellee',
                                            fontWeight: FontWeight.w700,
                                          )),
                                    ),
                                  );
                                }

                                if (profile is DnDCharacter) {
                                  final character = profile;
                                  return AppButton(
                                    color: ButtonColors.red,
                                    width: double.infinity,
                                    onPressed: () {
                                      choosedProfile = profile;

                                      title = 'DnD Character';
                                      content = 'Name: ${profile.name}\n'
                                          'Race: ${profile.race}\n'
                                          'Class: ${profile.characterClass}\n'
                                          'Strength: ${profile.strength}\n'
                                          'Dexterity: ${profile.dexterity}\n'
                                          'Constitution: ${profile.constitution}\n'
                                          'Intelligence: ${profile.intelligence}\n'
                                          'Wisdom: ${profile.wisdom}\n'
                                          'Charisma: ${profile.charisma}\n'
                                          'Weapon: ${profile.weapon ?? "None"}\n'
                                          'Class Abilities: ${profile.classAbilities ?? "None"}';

                                      setState(() {});
                                      controller.flipcard();
                                    },
                                    widget: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("DnD: " + character.name,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'Jellee',
                                            fontWeight: FontWeight.w700,
                                          )),
                                    ),
                                  );
                                }

                                if (profile is PathfinderCharacter) {
                                  final character = profile;
                                  return AppButton(
                                    color: ButtonColors.green,
                                    width: double.infinity,
                                    onPressed: () {
                                      choosedProfile = profile;

                                      title = 'Pathfinder Character';
                                      content = 'Name: ${profile.name}\n'
                                          'Race: ${profile.race}\n'
                                          'Class: ${profile.characterClass}\n'
                                          'Strength: ${profile.strength}\n'
                                          'Dexterity: ${profile.dexterity}\n'
                                          'Constitution: ${profile.constitution}\n'
                                          'Intelligence: ${profile.intelligence}\n'
                                          'Wisdom: ${profile.wisdom}\n'
                                          'Charisma: ${profile.charisma}\n'
                                          'Special Abilities: ${profile.specialAbilities ?? "None"}';
                                      setState(() {});
                                      controller.flipcard();
                                    },
                                    widget: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          Text("Pathfinder: " + character.name,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontFamily: 'Jellee',
                                                fontWeight: FontWeight.w700,
                                              )),
                                    ),
                                  );
                                }

                                return const SizedBox();
                              }),
                    ),
                    Spacer(),
                    AppButton(
                      width: double.infinity,
                      color: ButtonColors.red,
                      onPressed: () => context.pop(),
                      widget: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Close',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Jellee',
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
  return chooseProfile;
}

void showCardDialog(BuildContext context, Game game, [bool needFlip = false]) {
  bool nFlip = needFlip;
  showAdaptiveDialog(
    context: context,
    builder: (BuildContext context) {

      final Challenge challenge = game.challenge;
      final controller = FlipCardController();

      final String description = game.description;
      final List<String> descriptionParts = description.split(' ');
      const int wrapIndex = 21;
      final String firstPart = descriptionParts.take(wrapIndex).join(' ');
      final String secondPart = descriptionParts.skip(wrapIndex).join(' ');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (nFlip) {
          controller.flipcard();
          nFlip = false;
        }
      });

      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: FlipCard(
          rotateSide: RotateSide.left,
          animationDuration: Duration(milliseconds: 600),
          onTapFlipping:
              true, //When enabled, the card will flip automatically when touched.
          axis: FlipAxis.vertical,
          controller: controller,
          backWidget: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return CardBack(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: SizedBox(
                    height: 700,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Gap(16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AppButton(
                                  isRound: true,
                                  color: game.isFavorite
                                      ? ButtonColors.pink
                                      : ButtonColors.grey,
                                  widget: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Icon(
                                      CupertinoIcons.heart_fill,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  onPressed: () {
                                    game.isFavorite = !game.isFavorite;

                                    setState(()=>context.read<GameBloc>().add(UpdateGame(game)));
                                  },
                                ),
                              ),
                              AppButton(
                                isRound: true,
                                color: game.isCollection
                                    ? ButtonColors.yellow
                                    : ButtonColors.grey,
                                widget: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Icon(
                                    CupertinoIcons.collections_solid,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                                onPressed: () {
                                  game.isCollection = !game.isCollection;
                                  setState(()=>context.read<GameBloc>().add(UpdateGame(game)));

                                },
                              ),
                              AppButton(
                                isRound: true,
                                color: ButtonColors.red,
                                widget: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Icon(
                                    Icons.track_changes_sharp,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                                onPressed: () => controller.flipcard(),
                              ),
                            ],
                          ),
                          Gap(16),
                          Column(
                            children: [
                              Text(
                                game.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontFamily: 'Jellee',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Gap(8),
                              Row(
                                children: [
                                  Image.asset(game.image, width: 127, height: 127),
                                  Gap(16),
                                  Expanded(
                                    child: Text(
                                      firstPart,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontFamily: 'Jellee',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                secondPart,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontFamily: 'Jellee',
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              Gap(16),
                              Text(
                                game.rules,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Jellee',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          frontWidget: AppCard(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                    ),
                  ),
                  Spacer(),
                  const Gap(16),
                  Text(
                    challenge.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 51,
                      fontFamily: 'Jellee',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Gap(16),
                  Text(
                    challenge.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontFamily: 'Jellee',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Gap(16),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Text(
                      game.name,
                      style: const TextStyle(
                        color: ui.Color.fromARGB(255, 221, 38, 6),
                        fontSize: 21,
                        fontFamily: 'Jellee',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: () => controller.flipcard(),
                  ),
                  const Gap(36),
                  Spacer(
                    flex: 2,
                  ),
                  if (challenge.status != ChallengeStatus.lock)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AppButton(
                          widget: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              challenge.status == ChallengeStatus.skip ||
                                      challenge.status == ChallengeStatus.finish
                                  ? 'Retry'
                                  : 'Skip',
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (challenge.status == ChallengeStatus.skip ||
                                challenge.status == ChallengeStatus.finish) {
                              game.challenge = game.challenge
                                  .copyWith(status: ChallengeStatus.start);
                              context.read<GameBloc>().add(UpdateGame(game));
                            } else {
                              game.challenge = game.challenge
                                  .copyWith(status: ChallengeStatus.skip);
                              context.read<GameBloc>().add(UpdateGame(game));
                            }
                            Navigator.pop(context);
                          },
                          color: ButtonColors.red,
                        ),
                        if (challenge.status == ChallengeStatus.unlock ||
                            challenge.status == ChallengeStatus.start)
                          AppButton(
                            widget: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                challenge.status == ChallengeStatus.unlock
                                    ? 'Start'
                                    : 'Complite',
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (challenge.status == ChallengeStatus.start) {
                                game.challenge = game.challenge
                                    .copyWith(status: ChallengeStatus.finish);
                                context.read<GameBloc>().add(UpdateGame(game));
                              } else {
                                game.challenge = game.challenge
                                    .copyWith(status: ChallengeStatus.start);
                                context.read<GameBloc>().add(UpdateGame(game));
                              }

                              Navigator.pop(context);
                            },
                            color: ButtonColors.green,
                          ),
                      ],
                    )
                  else
                    Center(
                      child: AppButton(
                        widget: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "You need to finish at least half of the last level",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPressed: () {},
                        color: ButtonColors.grey,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
