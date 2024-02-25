import 'package:flutter/material.dart';
import 'package:fullnoteapp/presentation/resources/strings_manager.dart';

import '../../resources/color_manager.dart';






//todo make icon size bigger
buildWelcomeSnackBar(String userName) {
  final snackBar = SnackBar(
    padding: const EdgeInsets.symmetric(vertical: 20),
    content: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: AppColor.green,
            ),
            const SizedBox(
              width: 25,
            ),
            Text(
              'Welcome $userName',
              style: const TextStyle(
                  fontSize: 20,
                  color: AppColor.white,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            AppStrings.signupSuccess,
            style: TextStyle(fontSize: 15, color: AppColor.white),
          ),
        ),
        const Text(
          AppStrings.letsStart,
          style: TextStyle(fontSize: 15, color: AppColor.white),
        ),
      ],
    ),
    backgroundColor: Colors.transparent,
    duration: const Duration(seconds: 5),
  );
  return snackBar;
}

buildFailureSnackBar({required String title, required String message}) {
  final snackBar = SnackBar(
    padding: const EdgeInsets.symmetric(vertical: 20),
    content: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outlined,
              color: AppColor.red,
            ),
            const SizedBox(
              width: 25,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  color: AppColor.white,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            message,
            style: const TextStyle(fontSize: 15, color: AppColor.white),
          ),
        ),
        const Text(
          AppStrings.tryAgain,
          style: TextStyle(fontSize: 15, color: AppColor.white),
        ),
      ],
    ),
    backgroundColor: Colors.transparent,
    duration: const Duration(seconds: 5),
  );
  return snackBar;
}

