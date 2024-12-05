import 'package:flutter/material.dart';

import '../../src/core/utils/app_icon.dart';
import '../../src/core/utils/icon_provider.dart';

import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  final List<String> icons = [
    IconProvider.home.buildImageUrl(),
    IconProvider.catalog.buildImageUrl(),
    IconProvider.diary.buildImageUrl(),
  ];

  late AnimationController _animationController;
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();

    // Контроллер для анимации масштабирования и других эффектов
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _iconAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Фиксированная высота для нижней панели
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFA701AA), Color(0xFF950098)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          ...List.generate(icons.length, (index) {
            bool isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                // Плавное изменение размеров и цвета
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // Добавляем свечение только для выбранного элемента
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: isSelected
                                ? Color(0xFFDF0EB7).withOpacity(0.5)
                                : Colors.transparent,
                            spreadRadius: 8,
                            blurRadius: 11,
                          )
                        ]
                      : [],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                          begin: 1.0, end: isSelected ? 1.2 : 1.0),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      builder: (context, scale, child) {
                        return Transform.scale(
                          scale: scale,
                          child: child,
                        );
                      },
                      child: AppIcon(
                        asset: icons[index],
                        width: 33,
                        height: 33,
                        color: isSelected
                            ? Colors.white
                            : Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                });
              },
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  // Плавное изменение размеров и цвета
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // Добавляем свечение только для выбранного элемента
                    boxShadow: _selectedIndex == 3
                        ? [
                            BoxShadow(
                              color: _selectedIndex == 3
                                  ? Color(0xFFDF0EB7).withOpacity(0.5)
                                  : Colors.transparent,
                              spreadRadius: 8,
                              blurRadius: 11,
                            )
                          ]
                        : [],
                  ),
                  child: Stack(alignment: Alignment.center, children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                          begin: 1.0, end: _selectedIndex == 3 ? 1.2 : 1.0),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      builder: (context, scale, child) {
                        return Transform.scale(
                          scale: scale,
                          child: child,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Icon(
                          Icons.shuffle,
                          size: 40,
                          color: _selectedIndex == 3
                              ? Colors.white
                              : Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ])))
        ]),
      ),
    );
  }
}
