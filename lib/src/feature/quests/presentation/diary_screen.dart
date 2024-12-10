import 'package:dicey_quests/routes/go_router_config.dart';
import 'package:dicey_quests/routes/route_value.dart';
import 'package:dicey_quests/src/feature/game/bloc/game_bloc.dart';
import 'package:dicey_quests/ui_kit/app_button/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        if (state is GameLoaded) {
          final userList = state.user;

          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  userList.length == 0
                      ? Center(
                          child: Text(
                            "Your diary is empty",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontFamily: 'Jellee',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                          itemCount: userList.length,
                          separatorBuilder: (context, index) => Gap(12),
                          itemBuilder: (context, index) => AppButton(
                            width: double.infinity,
                            color: ButtonColors.orange,
                            widget: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Status: " + userList[index].status.name,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: 'Jellee',
                                      fontWeight: FontWeight.w700,
                                    ),
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Gap(8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        userList[index].name,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 26,
                                          fontFamily: 'Jellee',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      AppButton(
                                        color: ButtonColors.darkOrange,
                                        widget: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            userList[index].boardGame,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontFamily: 'Jellee',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gap(8),
                                  Text(
                                    userList[index].description,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: 'Jellee',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Gap(8),
                                  Row(
                                    children: [
                                      AppButton(
                                        isRound: true,
                                        color: ButtonColors.red,
                                        widget: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                        onPressed: () =>
                                            context.read<GameBloc>().add(
                                                  RemoveUser(userList[index]),
                                                ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${userList[index].date.day}.${userList[index].date.month}.${userList[index].date.year}",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontFamily: 'Jellee',
                                          fontWeight: FontWeight.w700,
                                        ),
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  Gap(16),
                  AppButton(
                    isRound: true,
                    color: ButtonColors.green,
                    widget: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Icon(
                        CupertinoIcons.plus,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    onPressed: () => context.push(
                        "${RouteValue.diary.path}/${RouteValue.write.path}"),
                  )
                ],
              ),
            ),
          );
        }
        if (state is GameLoading) {}
        if (state is GameError) {}
        return const Placeholder();
      },
    );
  }
}
