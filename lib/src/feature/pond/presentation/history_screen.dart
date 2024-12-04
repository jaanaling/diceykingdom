import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pond_care/src/core/utils/icon_provider.dart';
import 'package:pond_care/src/feature/pond/bloc/pond_bloc.dart';
import 'package:pond_care/ui_kit/app_bar/app_bar.dart';
import 'package:pond_care/ui_kit/app_button/app_button.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Padding(
            padding: EdgeInsets.only(top: 139 + MediaQuery.of(context).padding.top),
            child: SafeArea(
              child: BlocBuilder<PondBloc, PondState>(
                builder: (context, state) {
                  if (state is PondLoaded) {
                    final tasks = state.history;
                    return ListView.separated(
                      itemCount: tasks.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => const Gap(11),
                      itemBuilder: (context, index) {
                        return AppButton(
                          radius: 17,
                          width: double.infinity,
                          color: ButtonColors.blue,
                          widget: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  "${tasks[index].title} in pond ${tasks[index].pondId}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                    fontFamily: 'Araside',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                const Gap(4),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Doned in ${tasks[index].finishDate}',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.6),
                                            fontSize: 27,
                                            fontFamily: 'Baby Bears',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                        if (tasks[index]
                                                .dueDate!
                                                .difference(
                                                    tasks[index].finishDate ??
                                                        DateTime.now())
                                                .inDays >
                                            0)
                                          Text(
                                            'Pending',
                                            style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.6),
                                              fontSize: 27,
                                              fontFamily: 'Baby Bears',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          )
                                        else
                                          Row(
                                            children: [
                                              Image.asset(
                                                IconProvider.error
                                                    .buildImageUrl(),
                                                width: 34,
                                                height: 34,
                                              ),
                                              const Gap(4),
                                              const Text(
                                                'Overdue',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 27,
                                                  fontFamily: 'Baby Bears',
                                                  fontWeight: FontWeight.w400,
                                                  height: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ),
        AppBarWidget(
          title: "History",
          hasBackIcon: true,
        ),
      ],
    );
  }
}
