import 'dart:ui' as ui;
import 'package:dicey_quests/routes/go_router_config.dart';
import 'package:dicey_quests/routes/route_value.dart';
import 'package:dicey_quests/src/core/utils/log.dart';
import 'package:dicey_quests/src/feature/game/bloc/game_bloc.dart';
import 'package:dicey_quests/src/feature/game/model/challenge.dart';
import 'package:dicey_quests/src/feature/game/model/game.dart';
import 'package:dicey_quests/ui_kit/app_button/app_button.dart';
import 'package:dicey_quests/ui_kit/app_card.dart';
import 'package:dicey_quests/ui_kit/app_container.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class PyramidScreen extends StatelessWidget {
  final controller = FlipCardController();

  PyramidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        if (state is GameLoaded) {
          final challenges = state.game.map((game) => game.challenge).toList();

          challenges.sort((a, b) => a.difficulty.compareTo(b.difficulty));
          List<List<Challenge>> challengesByLevel = [];
          for (int i = 1; i <= 6; i++) {
            challengesByLevel
                .add(challenges.where((c) => c.difficulty == i).toList());
          }

          double totalChallenges = challenges.length.toDouble();
          double completedChallenges = challenges
              .where((c) => c.status == ChallengeStatus.finish)
              .length
              .toDouble();

          double progress =
              totalChallenges > 0 ? completedChallenges / totalChallenges : 0.0;

          logger.d(progress);
          logger.d(totalChallenges);
          logger.d(completedChallenges);
          logger.d(challenges);

          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.separated(
                    reverse: true,
                    itemCount: challengesByLevel.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const Gap(6),
                    itemBuilder: (context, levelIndex) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Отображение номера уровня
                        Text(
                          'X${levelIndex + 1}',
                          style: const TextStyle(
                            fontSize: 26,
                          ),
                        ),
                        const Spacer(), // Добавляет гибкое пространство между текстом и ListView

                        // Ограничиваем высоту и ширину внутреннего скролла
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.15,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: challengesByLevel[levelIndex]
                                .map(
                                  (challenge) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    child: buildBall(
                                      challenge,
                                      context,
                                      state.game.firstWhere(
                                        (test) =>
                                            test.challenge.name ==
                                            challenge.name,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const Spacer(
                            // Добавляет больше гибкого пространства справа
                            ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue,
                    minHeight: 8,
                  ),
                ),
                Spacer(),
                Text(
                  state.score.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 51,
                  ),
                ),
                Spacer(
                  flex: 2,
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
    );
  }

  Widget buildBall(Challenge challenge, BuildContext context, Game game) {
    String image;
    switch (challenge.status) {
      case ChallengeStatus.lock:
        image = 'assets/images/grey_ball.png';
        break;
      case ChallengeStatus.unlock:
        image = 'assets/images/yellow_ball.png';
        break;
      case ChallengeStatus.finish:
        image = 'assets/images/green_ball.png';
        break;
      case ChallengeStatus.skip:
        image = 'assets/images/red_ball.png';
        break;
      case ChallengeStatus.start:
        image = 'assets/images/aqua_ball.png';
        break;
    }
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => showChallengeDialog(context, game),
      child: Image.asset(
        image,
        width: MediaQuery.of(context).size.width * 0.12,
        height: MediaQuery.of(context).size.width * 0.12,
        fit: BoxFit.cover,
      ),
    );
  }

  void showChallengeDialog(
    BuildContext context,
    Game game,
  ) {
    final width = MediaQuery.of(context).size.width;
    final Challenge challenge = game.challenge;

    final String description = game.description;
    final List<String> descriptionParts = description.split(' ');
    const int wrapIndex = 21;
    final String firstPart = descriptionParts.take(wrapIndex).join(' ');
    final String secondPart = descriptionParts.skip(wrapIndex).join(' ');

    showAdaptiveDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: FlipCard(
            rotateSide: RotateSide.left,
            animationDuration: Duration(milliseconds: 600),
            onTapFlipping:
                true, //When enabled, the card will flip automatically when touched.
            axis: FlipAxis.vertical,
            controller: controller,
            backWidget: CardBack(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: SizedBox(
                  height: 700,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.close),
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.close),
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.close),
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
                          color: Color(0xFFFFBB00),
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
                            widget: Text(
                              challenge.status == ChallengeStatus.skip ||
                                      challenge.status == ChallengeStatus.finish
                                  ? 'Retry'
                                  : 'Skip',
                              style: const TextStyle(
                                fontSize: 24,
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
                              widget: Text(
                                challenge.status == ChallengeStatus.unlock
                                    ? 'Start'
                                    : 'Complite',
                                style: const TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                              onPressed: () {
                                if (challenge.status == ChallengeStatus.start) {
                                  game.challenge = game.challenge
                                      .copyWith(status: ChallengeStatus.finish);
                                  context
                                      .read<GameBloc>()
                                      .add(UpdateGame(game));
                                } else {
                                  game.challenge = game.challenge
                                      .copyWith(status: ChallengeStatus.start);
                                  context
                                      .read<GameBloc>()
                                      .add(UpdateGame(game));
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
                          widget: Text(
                            "You need to finish at least half of the last level",
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          onPressed: () {},
                          color: ButtonColors.lightBlue,
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
}
