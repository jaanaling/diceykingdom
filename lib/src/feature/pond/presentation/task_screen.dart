// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pond_care/routes/route_value.dart';
import 'package:pond_care/src/core/utils/app_icon.dart';
import 'package:pond_care/src/core/utils/icon_provider.dart';
import 'package:pond_care/src/feature/pond/bloc/pond_bloc.dart';
import 'package:pond_care/src/feature/pond/models/pond.dart';

import 'package:pond_care/src/feature/pond/models/task.dart';
import 'package:pond_care/ui_kit/app_bar/app_bar.dart';
import 'package:pond_care/ui_kit/app_button/app_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import 'choose_screen.dart';

class TaskScreen extends StatefulWidget {
  final Pond pond;
  const TaskScreen({
    super.key,
    required this.pond,
  });

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool isAllTask = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Stack(
          children: [
            BlocBuilder<PondBloc, PondState>(
              builder: (context, state) {
                if (state is PondLoaded) {
                  final pond = state.pond
                      .firstWhere((element) => element.id == widget.pond.id);
                  final tasks = pond.tasks
                          ?.where((test) =>
                              isAllTask ||
                              test.dueDate!.difference(DateTime.now()).inDays < 0)
                          .toList() ??
                      [];
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 13, vertical: 35),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Gap(114),
                          Stack(
                            children: [
                              Container(
                                width: 258,
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
                                        isAllTask = !isAllTask;
                                      });
                                    },
                                    isSelected: isAllTask,
                                    width: 129,
                                    child: Text(
                                      'all tasks',
                                      key: ValueKey<bool>(isAllTask),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: isAllTask
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
                                        isAllTask = !isAllTask;
                                      });
                                    },
                                    isSelected: !isAllTask,
                                    width: 129,
                                    child: Text(
                                      'overdue',
                                      key: ValueKey<bool>(!isAllTask),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: !isAllTask
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
                          Gap(11),
                          AppButton(
                            color: ButtonColors.lightBlue,
                            widget: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: Icon(
                                Icons.history,
                                size: 28,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () => context.push(
                              "${RouteValue.home.path}/${RouteValue.details.path}/${RouteValue.tasks.path}/${RouteValue.history.path}",
                            ),
                          ),
                          Gap(11),
                          ListView.separated(
                              itemCount: tasks.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) => Gap(11),
                              itemBuilder: (context, index) {
                                return AppButton(
                                    radius: 17,
                                    width: double.infinity,
                                    color: ButtonColors.blue,
                                    widget: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            tasks[index].title,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 23,
                                              fontFamily: 'Araside',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          ),
                                          Gap(4),
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Done in ${tasks[index].dueDate!.difference(DateTime.now()).inDays} days",
                                                    style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.6),
                                                      fontSize: 27,
                                                      fontFamily: 'Baby Bears',
                                                      fontWeight: FontWeight.w400,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  tasks[index]
                                                              .dueDate!
                                                              .difference(
                                                                  DateTime.now())
                                                              .inDays >
                                                          0
                                                      ? Text(
                                                          "Pending",
                                                          style: TextStyle(
                                                            color: Colors.white
                                                                .withOpacity(0.6),
                                                            fontSize: 27,
                                                            fontFamily:
                                                                'Baby Bears',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height: 0,
                                                          ),
                                                        )
                                                      : Row(
                                                          children: [
                                                            Image.asset(
                                                              IconProvider.error
                                                                  .buildImageUrl(),
                                                              width: 34,
                                                              height: 34,
                                                            ),
                                                            Gap(4),
                                                            Text(
                                                              "Overdue",
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 27,
                                                                fontFamily:
                                                                    'Baby Bears',
                                                                fontWeight:
                                                                    FontWeight.w400,
                                                                height: 0,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                ],
                                              ),
                                              Spacer(),
                                              AppButton(
                                                  color: ButtonColors.green,
                                                  widget: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 12,
                                                            vertical: 11),
                                                    child: Text(
                                                      "Complete",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontFamily: 'Araside',
                                                        fontWeight: FontWeight.w400,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () => context
                                                      .read<PondBloc>()
                                                      .add(UpdateTasks(tasks[index],
                                                          widget.pond)))
                                            ],
                                          )
                                        ],
                                      ),
                                    ));
                              })
                        ],
                      ),
                    ),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            AppBarWidget(title: 'Recommended${MediaQuery.of(context).size.shortestSide >= 600?' ':'\n'}Tasks', hasBackIcon: true,)
          ],
        ),
        if (!isRecommendationScreenLoaded)
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.6799999833106995),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    children: [
                      Gap(MediaQuery.of(context).size.height * 0.147 -
                          MediaQuery.of(context).padding.top),
                      Text(
                        'LET’S TAKE CARE OF YOUR POND!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 33,
                          fontFamily: 'Araside',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Gap(10),
                      Text(
                        'Here are the tasks you need to do to keep your pond healthy: feeding fish, checking water quality, and adding new plants or decorations.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontFamily: 'Baby Bears',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -(MediaQuery.of(context).size.height * 0.281),
                child: AppIcon(
                  asset: IconProvider.masqot4.buildImageUrl(),
                  width: MediaQuery.of(context).size.width * 1.23,
                  height: MediaQuery.of(context).size.height * 0.887,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 104),
                  child: AppButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool('recommendationScreen', true);

                      setState(() {
                        isRecommendationScreenLoaded = true;
                      });
                    },
                    color: ButtonColors.green,
                    widget: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 54),
                      child: Text(
                        'Got It!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 31,
                          fontFamily: 'Araside',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
      ],
    );
  }
}
