import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pond_care/src/core/utils/app_icon.dart';
import 'package:pond_care/src/core/utils/icon_provider.dart';
import 'package:pond_care/ui_kit/app_button/app_button.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final bool hasBackIcon;
  const AppBarWidget({super.key, required this.title, this.hasBackIcon = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AppIcon(
          asset: IconProvider.appBar.buildImageUrl(),
          width: MediaQuery.of(context).size.width,
          height: 114+MediaQuery.of(context).padding.top,
          fit: BoxFit.fill,
        ),
        if (hasBackIcon)

          Positioned(
            top: 6 + MediaQuery.of(context).padding.top,
            left: 10,
            child: AppButton(
              color: ButtonColors.lightBlue,
              onPressed: () {
                context.pop();
              },
              widget: SizedBox(
                width: 52,
                height: 44,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppIcon(asset: IconProvider.back.buildImageUrl(), width: 28.98, height: 20.9,),
                      const Gap(1),
                      const Text(
                        'back',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Araside',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        Positioned(
          bottom: 22,
          child: Stack(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 36,
                    fontFamily: 'Araside',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    color: Colors.white),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontFamily: 'Araside',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2
                    ..color = const Color(0xFF003079),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
