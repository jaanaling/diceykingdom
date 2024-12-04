import 'package:flutter/cupertino.dart';


class AppIcon extends StatelessWidget {
  final String asset;
  final Color? color;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BlendMode blendMode;

  const AppIcon({
    super.key,
    required this.asset,
    this.color,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.blendMode = BlendMode.srcIn,
  });

  @override
  Widget build(BuildContext context) {



    return Image.asset(
            asset,
            width: width,
            height: height,
            fit: fit,
            color: color,
            colorBlendMode: blendMode,
          );
  }
}
