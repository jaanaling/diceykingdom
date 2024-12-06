import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:inner_glow/inner_glow.dart';

class AppTextField extends StatelessWidget {
  final double width;

  final TextInputType textInputType;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Widget? suffix;
  final String? placeholder;
  final double height;
  final String? topText;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    required this.controller,
    this.placeholder,
    this.textInputType = TextInputType.text,
    this.width = 0.888,
    this.onChanged,
    this.suffix,
    required this.height,
    this.inputFormatters,
    this.topText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (topText != null)
          Text(
            topText ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: 'Jellee',
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0,
                  color: Colors.black.withOpacity(0.5),
                ),
              ],
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        Gap(8),
        InnerGlow(
            width: width * MediaQuery.of(context).size.width,
            height: height + 10,
            glowRadius: 20,
            strokeLinearGradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.black.withOpacity(0.15)],
            ),
            baseDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey,
              border: Border.all(width: 1, color: Colors.white),
              boxShadow: [
                BoxShadow(
                  color: Color(0x63220052),
                  blurRadius: 6.40,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Center(
              child: InnerGlow(
                width: width * MediaQuery.of(context).size.width - 10,
                height: height,
                glowRadius: 15,
                strokeLinearGradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.35),
                    Colors.black.withOpacity(0.15)
                  ],
                ),
                baseDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.white),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 19, right: 14),
                    child: CupertinoTextField(
                      textAlignVertical: TextAlignVertical.center,
                      suffix: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: suffix == null ? 0 : 12,
                            vertical: suffix == null ? 0 : 13),
                        child: suffix,
                      ),
                      placeholder: placeholder,
                      placeholderStyle: const TextStyle(
                          color: Color(0x35561A9E),
                          fontSize: 35,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.05,
                          shadows: []),
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      controller: controller,
                      onChanged: onChanged,
                      keyboardType: textInputType,
                      style: TextStyle(
                        fontSize: 31,
                        color: Color(0xFF1E0042),
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 4.0,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ],
                      ),
                      inputFormatters: inputFormatters,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
