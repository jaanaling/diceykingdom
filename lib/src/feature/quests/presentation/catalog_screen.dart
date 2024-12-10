import 'dart:math';

import 'package:dicey_quests/src/feature/game/bloc/game_bloc.dart';
import 'package:dicey_quests/src/feature/quests/presentation/show_card_dialog.dart';
import 'package:dicey_quests/ui_kit/app_button/app_button.dart';
import 'package:dicey_quests/ui_kit/app_card.dart';
import 'package:dicey_quests/ui_kit/app_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../ui_kit/text_field.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  bool isFavorite = false;
  bool isCollection = false;
  String? selectedAge;
  String? selectedGanre;
  String? selectedTime;
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          if (state is GameLoaded) {
            final gameList = state.game
                .where((element) =>
                    element.name
                        .toLowerCase()
                        .contains(controller.text.toLowerCase()) &&
                    (selectedAge == null ? true : element.age == selectedAge) &&
                    (selectedGanre == null
                        ? true
                        : element.genre.contains(selectedGanre)) &&
                    (selectedTime == null
                        ? true
                        : element.playTime == selectedTime) &&
                    (isFavorite == false || element.isFavorite == isFavorite) &&
                    (isCollection == false ||
                        element.isCollection == isCollection))
                .toList();

            Set<String> ageList = state.game.map((g) => g.age).toSet();

            Set<String> ganreList = state.game
                .expand((g) => g.genre) // Расширяем вложенные списки
                .toSet(); // Создаем множество
            Set<String> timeList = state.game.map((g) => g.playTime).toSet();

            return SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppTextField(
                              width: 0.5,
                              textInputType: TextInputType.text,
                              onChanged: (value) {
                                setState(() {
                                  controller.text = value;
                                });
                              },
                              validator: (value) {
                                return null;
                              },
                              onSaved: (value) {
                                setState(() {
                                  controller.text = value!;
                                });
                              },
                              controller: controller,
                              height: 55,
                              textSize: 15,
                              placeholder: 'search...',
                            ),
                            AppButton(
                                onPressed: () => setState(() {
                                      isFavorite = !isFavorite;
                                    }),
                                isRound: true,
                                color: isFavorite
                                    ? ButtonColors.pink
                                    : ButtonColors.grey,
                                widget: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Icon(
                                    CupertinoIcons.heart_fill,
                                    size: 36,
                                    color: Colors.white,
                                  ),
                                )),
                            AppButton(
                                onPressed: () => setState(() {
                                      isCollection = !isCollection;
                                    }),
                                isRound: true,
                                color: isCollection
                                    ? ButtonColors.yellow
                                    : ButtonColors.grey,
                                widget: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Icon(
                                    CupertinoIcons.collections_solid,
                                    size: 36,
                                    color: Colors.white,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Gap(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppButton(
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: ButtonColors.pink,
                            widget: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                (selectedAge as String?) ?? "Select age",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Jellee',
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (_) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 250,
                                      child: CupertinoPicker(
                                        backgroundColor: Colors.white,
                                        itemExtent: 32,
                                        onSelectedItemChanged: (index) {
                                          setState(() {
                                            selectedAge =
                                                ageList.elementAt(index);
                                          });
                                        },
                                        children: ageList
                                            .map((option) => Text(option))
                                            .toList(),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CupertinoButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              setState(() {
                                                selectedAge = null;
                                                context.pop();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          AppButton(
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: ButtonColors.yellow,
                            widget: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                (selectedGanre as String?) ?? "Select ganre",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Jellee',
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (_) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 250,
                                      child: CupertinoPicker(
                                        backgroundColor: Colors.white,
                                        itemExtent: 32,
                                        onSelectedItemChanged: (index) {
                                          setState(() {
                                            selectedGanre =
                                                ganreList.elementAt(index);
                                          });
                                        },
                                        children: ganreList
                                            .map((option) => Text(option))
                                            .toList(),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CupertinoButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              setState(() {
                                                selectedGanre = null;
                                                context.pop();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          AppButton(
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: ButtonColors.green,
                            widget: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                (selectedTime as String?) ?? "Select time",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Jellee',
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (_) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 250,
                                      child: CupertinoPicker(
                                        backgroundColor: Colors.white,
                                        itemExtent: 32,
                                        onSelectedItemChanged: (index) {
                                          setState(() {
                                            selectedTime =
                                                timeList.elementAt(index);
                                          });
                                        },
                                        children: timeList
                                            .map((option) => Text(option))
                                            .toList(),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CupertinoButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              setState(() {
                                                selectedTime = null;
                                                context.pop();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                        itemCount: gameList.length,
                        separatorBuilder: (_, __) => Gap(16),
                        itemBuilder: (context, index) => CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => showCardDialog(
                            context,
                            gameList[index],
                            true,
                          ),
                          child: AppContainer(
                              width: double.infinity,
                              height: 130,
                              borderRadius: 25,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: Row(
                                  children: [
                                    Image.asset(gameList[index].image,
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover),
                                    Gap(16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              gameList[index].name,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 26,
                                                fontFamily: 'Jellee',
                                                fontWeight: FontWeight.w700,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Gap(8),
                                          Expanded(
                                            child: Text(
                                              gameList[index].description,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontFamily: 'Jellee',
                                                fontWeight: FontWeight.w700,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is GameLoading) {}
          if (state is GameError) {}
          return Container();
        },
      ),
    );
  }
}
