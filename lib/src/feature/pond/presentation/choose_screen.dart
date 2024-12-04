import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pond_care/src/core/utils/app_icon.dart';
import 'package:pond_care/src/feature/pond/bloc/pond_bloc.dart';
import 'package:pond_care/src/feature/pond/models/decoration.dart';
import 'package:pond_care/ui_kit/app_bar/app_bar.dart';
import 'package:pond_care/ui_kit/app_button/app_button.dart';

import '../models/fish.dart';
import '../models/plant.dart';
import 'add_pond_screen.dart';

class ChooseScreen extends StatefulWidget {
  final ChooseType type;
  const ChooseScreen({super.key, required this.type});

  @override
  State<ChooseScreen> createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  List<Object> _sortedList = [];
  bool isShowAll = true;

  @override
  Widget build(BuildContext context) {
    final bool isIpad = MediaQuery.of(context).size.shortestSide >= 600;
    final width = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SingleChildScrollView(
          child: BlocBuilder<PondBloc, PondState>(
            builder: (context, state) {
              if (state is PondLoaded) {
                if (_sortedList.isEmpty) {
                  _sortedList = (widget.type == ChooseType.decorations
                      ? state.decorations
                      : widget.type == ChooseType.fish
                          ? state.fish
                          : state.plants)
                    ..sort((a, b) {
                      final aSelected = isSelected(
                        item: a,
                        type: widget.type,
                      )
                          ? 1
                          : 0;
                      final bSelected = isSelected(
                        item: b,
                        type: widget.type,
                      )
                          ? 1
                          : 0;
                      return bSelected - aSelected;
                    });
                }
                List<Object> list = _sortedList;
                if (!isShowAll) {
                  list = widget.type == ChooseType.fish
                      ? getRecommendedFish(
                          selectedFish,
                          _sortedList as List<Fish>,
                        )
                      : widget.type == ChooseType.decorations
                          ? getRecommendedDecorations(
                              selectedFish,
                              selectedPlants,
                              _sortedList as List<Decorations>,
                            )
                          : getRecommendedPlants(
                              selectedPlants,
                              _sortedList as List<Plant>,
                            );
                }

                return Column(
                  children: [
                    Gap(160+ MediaQuery.of(context).padding.top),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 23),
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 38,
                            decoration: ShapeDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.5),
                                  Colors.black.withOpacity(0.39),
                                ],
                                stops: const [0.5, 1.0],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(19),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 1000),
                              child: SelectedOptionWidget(
                                onPressed: () {
                                  setState(() {
                                    isShowAll = !isShowAll;
                                  });
                                },
                                isSelected: isShowAll,
                                width: width * 0.358,
                                child: Text(
                                  'show all',
                                  key: ValueKey<bool>(isShowAll),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: isShowAll
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.73),
                                    fontSize: 27,
                                    fontFamily: 'Baby Bears',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 1000),
                              child: SelectedOptionWidget(
                                onPressed: () {
                                  setState(() {
                                    isShowAll = !isShowAll;
                                  });
                                },
                                isSelected: !isShowAll,
                                width: width * 0.555,
                                child: Text(
                                  'show recommended',
                                  key: ValueKey<bool>(!isShowAll),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: !isShowAll
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.73),
                                    fontSize: 27,
                                    fontFamily: 'Baby Bears',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        children: isShowAll
                            ? _sortedList.map((item) {
                                return ElementWidget(
                                  element: item,
                                  isSelected:
                                      isSelected(item: item, type: widget.type),
                                  onSelectionChange: () {
                                    setState(() {
                                      if (widget.type ==
                                              ChooseType.decorations &&
                                          item is Decorations) {
                                        if (selectedDecorations.any(
                                          (decoration) =>
                                              decoration.id == item.id,
                                        )) {
                                          selectedDecorations.removeWhere(
                                            (decoration) =>
                                                decoration.id == item.id,
                                          );
                                        } else {
                                          selectedDecorations.add(item);
                                        }
                                      } else if (widget.type ==
                                              ChooseType.fish &&
                                          item is Fish) {
                                        if (selectedFish.any(
                                          (fish) => fish.id == item.id,
                                        )) {
                                          selectedFish.removeWhere(
                                            (fish) => fish.id == item.id,
                                          );
                                        } else {
                                          selectedFish.add(item);
                                        }
                                      } else if (widget.type ==
                                              ChooseType.plants &&
                                          item is Plant) {
                                        if (selectedPlants.any(
                                          (plant) => plant.id == item.id,
                                        )) {
                                          selectedPlants.removeWhere(
                                            (plant) => plant.id == item.id,
                                          );
                                        } else {
                                          selectedPlants.add(item);
                                        }
                                      }
                                    });
                                  },
                                );
                              }).toList()
                            : list.map((item) {
                                return ElementWidget(
                                  element: item,
                                  isSelected:
                                      isSelected(item: item, type: widget.type),
                                  onSelectionChange: () {
                                    setState(() {
                                      if (widget.type ==
                                              ChooseType.decorations &&
                                          item is Decorations) {
                                        if (selectedDecorations.any(
                                          (decoration) =>
                                              decoration.id == item.id,
                                        )) {
                                          selectedDecorations.removeWhere(
                                            (decoration) =>
                                                decoration.id == item.id,
                                          );
                                        } else {
                                          selectedDecorations.add(item);
                                        }
                                      } else if (widget.type ==
                                              ChooseType.fish &&
                                          item is Fish) {
                                        if (selectedFish.any(
                                          (fish) => fish.id == item.id,
                                        )) {
                                          selectedFish.removeWhere(
                                            (fish) => fish.id == item.id,
                                          );
                                        } else {
                                          selectedFish.add(item);
                                        }
                                      } else if (widget.type ==
                                              ChooseType.plants &&
                                          item is Plant) {
                                        if (selectedPlants.any(
                                          (plant) => plant.id == item.id,
                                        )) {
                                          selectedPlants.removeWhere(
                                            (plant) => plant.id == item.id,
                                          );
                                        } else {
                                          selectedPlants.add(item);
                                        }
                                      }
                                    });
                                  },
                                );
                              }).toList(),
                      ),
                    ),
                    const Gap(16),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        AppBarWidget(
          title:
              'Choose${widget.type == ChooseType.decorations ? '${!isIpad ? '\n' : ''}Decorations' : widget.type == ChooseType.fish ? ' Fish' : ' Plants'}',
          hasBackIcon: true,
        ),
      ],
    );
  }
}

bool isSelected({
  required Object item,
  required ChooseType type,
}) {
  if (type == ChooseType.decorations && item is Decorations) {
    return selectedDecorations.any((decoration) => decoration.id == item.id);
  } else if (type == ChooseType.fish && item is Fish) {
    return selectedFish.any((fish) => fish.id == item.id);
  } else if (type == ChooseType.plants && item is Plant) {
    return selectedPlants.any((plant) => plant.id == item.id);
  }
  return false;
}

class ElementWidget extends StatelessWidget {
  final dynamic element;
  final bool isSelected;
  final VoidCallback onSelectionChange;
  const ElementWidget({
    super.key,
    this.element,
    required this.isSelected,
    required this.onSelectionChange,
  });
  Future<dynamic> showDialog(
    BuildContext context,
  ) {
    final type = element is Decorations
        ? ChooseType.decorations
        : element is Plant
            ? ChooseType.plants
            : ChooseType.fish;
    if (type == ChooseType.decorations) {
      final Decorations el = element as Decorations;
      return showAdaptiveDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.6,
              child: AppButton(
                color: ButtonColors.pink,
                widget: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        titleAlert(el.name),
                        const Gap(8),
                        AppIcon(asset: el.imageUrl ?? ''),
                        const Gap(8),
                        alertText('Material: ${el.material}'),
                        alertText('Size: ${el.size}'),
                        alertText(
                          'Safe for fish: ${el.safeForFish ? 'Yes' : 'No'}',
                        ),
                        alertText(
                          'Pollutant source: ${el.pollutantSource ? 'Yes' : 'No'}',
                        ),
                        alertText(
                          'Blocks swimming: ${el.blocksSwimming ? 'Yes' : 'No'}',
                        ),
                        alertText(
                          'Supports fish hiding: ${el.supportsFishHiding ? 'Yes' : 'No'}',
                        ),
                        const Gap(16),
                        RowButtons(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else if (type == ChooseType.fish) {
      final Fish el = element as Fish;
      return showAdaptiveDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: AppButton(
                color: ButtonColors.blue,
                widget: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        titleAlert(el.name),
                        const Gap(8),
                        AppIcon(asset: el.imageUrl ?? ''),
                        const Gap(8),
                        alertText('Size: ${el.size}'),
                        alertText('Min. oxygen level: ${el.minOxygenLevel}'),
                        alertText('Max. oxygen level: ${el.maxOxygenLevel}'),
                        alertText('Min. temperature: ${el.minTemperature}'),
                        alertText('Max. temperature: ${el.maxTemperature}'),
                        alertText(
                            'Aggression: ${el.aggressive ? 'Yes' : 'No'}'),
                        alertText(
                          "Recommended fish: ${el.recommendedFish.join(', ')}",
                        ),
                        const Gap(16),
                        RowButtons(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      final Plant el = element as Plant;
      return showAdaptiveDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.6,
              child: AppButton(
                color: ButtonColors.green,
                widget: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        titleAlert(el.name),
                        const Gap(8),
                        AppIcon(asset: el.imageUrl ?? ''),
                        const Gap(8),
                        alertText('Size: ${el.size}'),
                        alertText('Light requirement: ${el.lightRequirement}'),
                        alertText('Growth rate: ${el.growthRate}'),
                        alertText('Min. temperature: ${el.minTemperature}'),
                        alertText('Max. temperature: ${el.maxTemperature}'),
                        const Gap(16),
                        RowButtons(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  Text titleAlert(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 23,
        fontFamily: 'Araside',
        fontWeight: FontWeight.w400,
        height: 0,
      ),
    );
  }

  Text alertText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white.withOpacity(0.73),
        fontSize: 27,
        fontFamily: 'Baby Bears',
        fontWeight: FontWeight.w400,
        height: 0,
      ),
    );
  }

  Row RowButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppButton(
          color: ButtonColors.red,
          onPressed: () => Navigator.of(context).pop(),
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: const Text(
              'Close',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Araside',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
        ),
        const Gap(16),
        AppButton(
          color: ButtonColors.lightBlue,
          onPressed: () {
            onSelectionChange();
            Navigator.of(context).pop();
          },
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Text(
              !isSelected ? 'Select' : 'Unselect',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Araside',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final type = element is Decorations
        ? ChooseType.decorations
        : element is Plant
            ? ChooseType.plants
            : ChooseType.fish;

    late final String? imageUrl;
    late final String name;

    if (type == ChooseType.decorations) {
      imageUrl = (element as Decorations).imageUrl;
      name = (element as Decorations).name;
    } else if (type == ChooseType.fish) {
      imageUrl = (element as Fish).imageUrl;
      name = (element as Fish).name;
    } else {
      imageUrl = (element as Plant).imageUrl;
      name = (element as Plant).name;
    }

    return Stack(
      children: [
        AppButton(
          color: type == ChooseType.decorations
              ? ButtonColors.pink
              : type == ChooseType.fish
                  ? ButtonColors.blue
                  : ButtonColors.green,
          onPressed: () => showDialog(context),
          radius: 17,
          width: 142,
          widget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              children: [
                AppIcon(asset: imageUrl ?? ''),
                const Gap(9),
                SizedBox(
                  height: 44,
                  width: 137,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontFamily: 'Araside',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                const Gap(8),
              ],
            ),
          ),
        ),
        Positioned(
          top: 6,
          right: 6,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onSelectionChange,
              borderRadius: BorderRadius.circular(32),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(-0.00, 1.00),
                        end: Alignment(0, -1),
                        colors: [Color(0xFFD9D9D9), Color(0xFFA2A2A2)],
                      ),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 0.50,
                          color: Color(0xFF999999),
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  AnimatedScale(
                    scale: isSelected ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(-0.00, 1.00),
                          end: Alignment(0, -1),
                          colors: [Color(0xFF0096F4), Color(0xFF48C8FF)],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SelectedOptionWidget extends StatelessWidget {
  final Widget child;
  final bool isSelected;
  final double width;
  final VoidCallback? onPressed;
  const SelectedOptionWidget({
    super.key,
    required this.child,
    required this.isSelected,
    required this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(19),
        child: Ink(
          height: 38,
          width: width,
          decoration: isSelected
              ? ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF57ACFF),
                      Color(0xFF2168D0),
                      Color(0xFF3088F6),
                      Color(0xFF084CB0),
                    ],
                    stops: [0.005, 0.15, 0.95, 1.0],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19),
                  ),
                )
              : null,
          child: Center(child: child),
        ),
      ),
    );
  }
}

List<Fish> getRecommendedFish(List<Fish> selectedFish, List<Fish> allFish) {
  return allFish.where((fish) {
    for (final selected in selectedFish) {
      if (!fish.aggressive &&
          fish.minOxygenLevel <= selected.maxOxygenLevel &&
          fish.maxOxygenLevel >= selected.minOxygenLevel &&
          fish.minTemperature <= selected.maxTemperature &&
          fish.maxTemperature >= selected.minTemperature) {
        return true;
      }
    }
    return false;
  }).toList();
}

/// Метод для проверки совместимости конкретной рыбы с другими рыбами в пруду
bool checkFishCompatibilityWith(Fish newFish, List<Fish> fish) {
  for (final f in fish) {
    if (!newFish.recommendedFish.contains(f.id) ||
        !f.recommendedFish.contains(newFish.id)) {
      return false;
    }
    if (newFish.aggressive && f.size != 'large') {
      return false; // Агрессивная рыба несовместима с мелкими рыбами
    }
  }
  return true;
}

/// Метод для получения рекомендованных растений для текущего состояния пруда
List<Plant> getRecommendedPlants(
  List<Plant> selectedPlants,
  List<Plant> allPlants,
) {
  return allPlants.where((plant) {
    for (final selected in selectedPlants) {
      if (plant.lightRequirement == selected.lightRequirement &&
          plant.growthRate == selected.growthRate &&
          plant.minTemperature <= selected.maxTemperature &&
          plant.maxTemperature >= selected.minTemperature) {
        return true;
      }
    }
    return false;
  }).toList();
}

/// Метод для проверки совместимости конкретного растения с текущими условиями пруда
bool checkPlantCompatibilityWith(Plant plant) {
  if (plant.sensitiveToPollution) {
    return false; // Растение чувствительно к загрязнению воды
  }
  return true;
}

/// Метод для получения рекомендованных декораций для текущего состояния пруда
List<Decorations> getRecommendedDecorations(
  List<Fish> selectedFish,
  List<Plant> selectedPlants,
  List<Decorations> allDecorations,
) {
  return allDecorations.where((decoration) {
    // Условие: безопасно для рыб и не блокирует их плавание
    if (!decoration.safeForFish || decoration.blocksSwimming) {
      return false;
    }

    // Условие: укрытия для рыб, если есть рыбы, которые этого требуют
    if (selectedFish.any((fish) => fish.needsShade)) {
      if (!decoration.supportsFishHiding) {
        return false;
      }
    }

    // Условие: совместимость с растениями (например, не источник загрязнения)
    if (selectedPlants.isNotEmpty && decoration.pollutantSource) {
      return false;
    }

    if(!decoration.interactive)
    {return false;}

    return true;
  }).toList();
}

/// Метод для проверки совместимости конкретной декорации с текущим состоянием пруда
bool checkDecorationCompatibilityWith(Decorations decoration) {
  if (!decoration.safeForFish ||
      decoration.pollutantSource ||
      decoration.blocksSwimming) {
    return false; // Декорация небезопасна для рыб
  }
  return true;
}

enum ChooseType { plants, fish, decorations }
