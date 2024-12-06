import 'package:dicey_quests/ui_kit/app_button/app_button.dart';
import 'package:dicey_quests/ui_kit/app_card.dart';
import 'package:dicey_quests/ui_kit/app_container.dart';
import 'package:flutter/cupertino.dart';

import '../../../../ui_kit/text_field.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [AppTextField(controller: controller, height: 80, placeholder: 'Example', topText: 'Example',), ],
        ),
      ),
    );
  }
}
