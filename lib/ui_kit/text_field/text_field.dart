import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final double width;
  final double? height;
  final TextInputType textInputType;
  final TextEditingController controller;
  final Function(String)? onChanged;
  const AppTextField(
      {super.key,
      this.width = double.infinity,
      this.height,
      required this.controller,
      this.textInputType = TextInputType.text,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          width: 5,
          color: const Color(0xFFD8F0FD),
        ),
        borderRadius: BorderRadius.circular(39),
        boxShadow: [
          const BoxShadow(
            color: Color(0x72000000),
            blurRadius: 4,
            offset: Offset(0, 5),
            spreadRadius: 0,
          )
        ],
      ),
      child: CupertinoTextField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        controller: controller,
        onChanged: onChanged,
        keyboardType: textInputType,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontFamily: 'Araside',
            fontWeight: FontWeight.w400,
            shadows: [
              Shadow(
                  // bottomLeft
                  offset: Offset(-1, -1),
                  color: Color(0xFF3256A2)),
              Shadow(
                  // bottomRight
                  offset: Offset(1, -1),
                  color: Color(0xFF3256A2)),
              Shadow(
                  // topRight
                  offset: Offset(1, 1),
                  color: Color(0xFF3256A2)),
              Shadow(
                  // topLeft
                  offset: Offset(-1, 1),
                  color: Color(0xFF3256A2)),
            ]),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [
                Color(0xFF88A2D7),
                Color(0xFFABC7EC),
                Color(0xFF9DBFE6),
                Color(0xFF88A2D7),
              ],
              stops: [
                0.0005,
                0.15,
                0.995,
                1.0
              ]),
          borderRadius: BorderRadius.circular(39),
        ),
      ),
    );
  }
}
