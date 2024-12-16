import 'package:advertising_id/advertising_id.dart';
import 'package:core_logic/core_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:go_router/go_router.dart';

import '../../../../../routes/route_value.dart';
import '../../../../core/utils/app_icon.dart';
import '../../../../core/utils/icon_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => InitializationCubit()..initialize(context),
      child: BlocListener<InitializationCubit, InitializationState>(
        listener: (context, state) {
          if (state is InitializedState) {
            context.go(state.startRoute);
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: AppIcon(
                asset: IconProvider.splash.buildImageUrl(),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            AppIcon(
              asset: IconProvider.logo.buildImageUrl(),
              width: 328,
              height: 260,
            ),
            Positioned(
              bottom: height * 0.122,
              child: const SpinKitFadingCircle(
                color: Colors.white,
                size: 98,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
