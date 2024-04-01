import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';

class EmptyHome extends StatelessWidget {
  const EmptyHome({super.key});

  @override
  Widget build(BuildContext context) {
   return const Center(
            child: Text(
          AppStrings.emptyBody,
          style: TextStyle(color: AppColor.white, fontSize: 25),
        ));
  }
}