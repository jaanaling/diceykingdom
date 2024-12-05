import 'package:dicey_quests/src/core/utils/app_icon.dart';
import 'package:dicey_quests/src/core/utils/icon_provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 1;

  List<String> icons = [
    IconProvider.catalog.buildImageUrl(),
    IconProvider.home.buildImageUrl(),
    IconProvider.diary.buildImageUrl()
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: const BoxDecoration(
        color: Color(0xFF950098),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(icons.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  // Glowing circle effect
                  if (_selectedIndex == index)
                    Positioned(
                      bottom: -15,
                      child: Container(
                        height: 53,
                        width: 53,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.8),
                              blurRadius: 11.9,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  AppIcon(
                    asset: icons[index],
                    color: _selectedIndex == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.7),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
