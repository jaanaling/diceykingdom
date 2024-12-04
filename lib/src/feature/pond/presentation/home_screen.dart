import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pond_care/routes/go_router_config.dart';
import 'package:pond_care/routes/route_value.dart';
import 'package:pond_care/src/feature/pond/bloc/pond_bloc.dart';
import 'package:pond_care/src/feature/pond/models/pond.dart';
import 'package:pond_care/ui_kit/app_bar/app_bar.dart';
import 'package:pond_care/ui_kit/app_button/app_button.dart';

import '../../../core/utils/app_icon.dart';
import '../../../core/utils/icon_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(top: 139),
            child: BlocBuilder<PondBloc, PondState>(
              builder: (context, state) {
                if (state is PondLoaded) {
                  return state.pond.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: 50+ MediaQuery.of(context).padding.top),
                          child: Text(
                            'No Ponds Here!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 31,
                              fontFamily: 'Araside',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) =>
                              PondItem(pond: state.pond[index]),
                          separatorBuilder: (BuildContext context, int index) =>
                              Gap(3),
                          itemCount: state.pond.length);
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
        AppBarWidget(
          title: 'All Ponds',
        ),
        Positioned(
          bottom: 0,
          child: Padding(
            padding: EdgeInsets.only(bottom: 104),
            child: AppButton(
              onPressed: () {
                context
                    .push('${RouteValue.home.path}/${RouteValue.addPond.path}');
              },
              color: ButtonColors.green,
              widget: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 54),
                child: Text(
                  'Add Pond',
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
    );
  }
}

class PondItem extends StatelessWidget {
  final Pond pond;
  const PondItem({super.key, required this.pond});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: AppButton(
          color: ButtonColors.blue,
          onPressed: () => context.push(
                "${RouteValue.home.path}/${RouteValue.details.path}",
                extra: pond,
              ),
          widget: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11),
                child: Stack(
                  children: [
                    pond.photoUrl == null
                        ? AppButton(
                            color: ButtonColors.green,
                            radius: 17,
                            widget: SizedBox(
                              width: 112,
                              height: 104,
                              child: Center(
                                child: AppIcon(
                                  asset: IconProvider.photo.buildImageUrl(),
                                  width: 59.14,
                                ),
                              ),
                            ))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(17),
                            child: Image.file(
                              File(pond.photoUrl!),
                              width: 112,
                              height: 112,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 188,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          pond.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'Araside',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 188,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Pond volume: ${pond.volume}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'Baby Bears',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        AppIcon(asset: IconProvider.fish.buildImageUrl()),
                        Gap(12),
                        Text(
                          pond.fish.length.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'Baby Bears',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        )
                      ],
                    ),
                    Text(
                      'Active Tasks: ${pond.tasks?.length ?? 0}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'Baby Bears',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    Text(
                      'Overdue Tasks: ${pond.tasks?.where((task) => task.dueDate != null && task.dueDate!.isBefore(DateTime.now())).length ?? 0}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'Baby Bears',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
