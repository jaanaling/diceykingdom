import 'package:dicey_quests/routes/route_value.dart';
import 'package:dicey_quests/src/core/utils/log.dart';
import 'package:dicey_quests/src/feature/game/bloc/game_bloc.dart';
import 'package:dicey_quests/src/feature/game/model/challenge.dart';
import 'package:dicey_quests/src/feature/game/model/game.dart';
import 'package:dicey_quests/src/feature/quests/presentation/show_card_dialog.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PyramidScreen extends StatelessWidget {
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

          double progress = (totalChallenges > 0
                  ? completedChallenges / totalChallenges
                  : 0.0) *
              100;

          logger.d(progress);
          logger.d(totalChallenges);
          logger.d(completedChallenges);
          logger.d(challenges);

          final bool isIpad = MediaQuery.of(context).size.shortestSide >= 600;

          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                
                  child: CupertinoButton(
                      padding: EdgeInsets.only(left: 10,top: 50),
                      onPressed: () =>
                          context.push("${RouteValue.home.path}/privicy"),
                      child: Icon(Icons.privacy_tip_sharp, color: Colors.white,)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
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
                          height: isIpad
                              ? MediaQuery.of(context).size.width * 0.1
                              : MediaQuery.of(context).size.width * 0.15,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: DecoratedBox(
                        decoration: ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.00, -1.00),
                            end: Alignment(0, 1),
                            colors: [
                              Color(0xFFC432E1),
                              Color(0xFF9C13B7),
                              Color(0xFF9B29B2)
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(59),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: StepProgressIndicator(
                            totalSteps: totalChallenges.ceil(),
                            currentStep: completedChallenges.ceil(),
                            fallbackLength:
                                MediaQuery.of(context).size.width * 0.625,
                            size: 14,
                            padding: 0,
                            roundedEdges: Radius.circular(17),
                            selectedGradientColor: LinearGradient(
                              begin: Alignment(0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [
                                Color(0xFF5AAC3C),
                                Color(0xFF30C339),
                                Color(0xFF157727)
                              ],
                            ),
                            unselectedColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Gap(10),
                    Text(
                      '${progress.toStringAsFixed(0)}%',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'Jellee',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    )
                  ],
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
                SizedBox(
                  height: 20,
                )
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
    final bool isIpad = MediaQuery.of(context).size.shortestSide >= 600;
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => showCardDialog(context, game),
        borderRadius: BorderRadius.circular(32),
        child: Ink.image(
          width: isIpad
              ? MediaQuery.of(context).size.width * 0.08
              : MediaQuery.of(context).size.width * 0.12,
          height: isIpad
              ? MediaQuery.of(context).size.width * 0.08
              : MediaQuery.of(context).size.width * 0.12,
          fit: BoxFit.cover,
          image: AssetImage(
            image,
          ),
        ),
      ),
    );
  }
}

class PrivicyScreen extends StatefulWidget {
  const PrivicyScreen({super.key});

  @override
  State<PrivicyScreen> createState() => _PrivicyScreenState();
}

class _PrivicyScreenState extends State<PrivicyScreen> {
  late final WebViewController _controller;
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: CupertinoColors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Privacy Policy'),
        leading: CupertinoNavigationBarBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: WebViewWidget(
                controller: _controller
                  ..loadRequest(Uri.parse("https://diceyquestaa.com/privacy"))
                  ..setBackgroundColor(
                    Colors.white,
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
