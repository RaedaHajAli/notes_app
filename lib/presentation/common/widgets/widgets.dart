import 'package:flutter/material.dart';
import 'package:fullnoteapp/presentation/resources/strings_manager.dart';

import '../../resources/color_manager.dart';


Widget buildCustomButton(
    {required String title,
    required Color textColor,
    required Color backgroundColor,
    required void Function()? onPressed,
    Color borderColor = Colors.transparent}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      textStyle: const TextStyle(color: Colors.white, fontSize: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: borderColor)),
    ),
    child: Container(
      width: double.infinity,
      height: 50,
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(fontSize: 20, color: textColor),
      ),
    ),
  );
}

Widget buildCustomTextField(
    {required TextEditingController controller,
    required TextInputType keyboardType,
    String? label,
    String? hint,
    IconData? prefix,
    IconData? suffixIcon,
    Function()? suffixPressed,
    void Function(String?)? onSaved,
    void Function(String)? onChanged,
    void Function(String)? onFieldSubmitted,
    bool obscureText = false,
    int? maxLines = 1,
    double borderRadius = 16,
    Color borderColor = Colors.grey,
    Color contentColor = Colors.grey,
    Color backgroundColor = Colors.grey,
    //String? Function(String?)? validator,
    String? errorText}) {
  return Container(
    decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius)),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onSaved: onSaved,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText,
      obscuringCharacter: '*',
      cursorColor: contentColor,
      maxLines: maxLines,
      // validator:validator ?? (value) {
      //   if (value?.isEmpty ?? true) {
      //     return 'Field is required';
      //   } else {
      //     return null;
      //   }
      // },
      style: TextStyle(color: contentColor),

      decoration: InputDecoration(
        fillColor: backgroundColor,
        labelText: label,
        labelStyle: TextStyle(color: contentColor),
        hintText: hint,
        hintStyle: TextStyle(color: contentColor),
        errorText: errorText,
        prefixIcon: Icon(
          prefix,
          color: contentColor,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffixIcon,
                  color: contentColor,
                ))
            : null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(
              color: Colors.red,
            )),
      ),
    ),
  );
}

Padding buildLable(String title) {
  return Padding(
    padding: const EdgeInsets.only(left: 8, bottom: 5),
    child: Text(
      title,
      style: TextStyle(color: AppColor.white.withOpacity(0.7), fontSize: 14),
    ),
  );
}

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

