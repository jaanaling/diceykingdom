import 'package:dicey_quests/ui_kit/app_container.dart';
import 'package:flutter/cupertino.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            AppContainer(
              child: Text('example'),
              width: 337,
              height: 158,
            )
          ],
        ),
      ),
    );
  }
}
