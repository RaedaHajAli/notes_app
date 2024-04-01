// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/images_manager.dart';
import '../resources/strings_manager.dart';

class AuthScreenLogo extends StatelessWidget {
  const AuthScreenLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Row(
          children: [
            Image.asset(
              AppImages.logo,
              width: 90,
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.noteApp,
                  style: TextStyle(
                      color: AppColor.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  AppStrings.noteSubTitle,
                  style: TextStyle(
                    color: AppColor.white.withOpacity(0.6),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 70,
        ),
      ],
    );
  }
}

class LabelText extends StatelessWidget {
  const LabelText({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 5),
      child: Text(
        title,
        style: TextStyle(color: AppColor.white.withOpacity(0.7), fontSize: 14),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      this.controller,
      required this.keyboardType,
      this.label,
      this.hint,
      this.prefix,
      this.suffixIcon,
      this.suffixPressed,
      this.onSaved,
      this.onChanged,
      this.onFieldSubmitted,
      this.validator,
      this.errorText,
      this.obscureText,
      this.maxLines,
      this.borderRadius,
      this.backgroundColor,
      this.borderColor,
      this.contentColor})
      : super(key: key);
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? label;
  final String? hint;
  final IconData? prefix;
  final IconData? suffixIcon;
  final Function()? suffixPressed;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final bool? obscureText;
  final int? maxLines;
  final double? borderRadius;
  final Color? borderColor;
  final Color? contentColor;
  final Color? backgroundColor;
  final String? Function(String?)? validator;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 16)),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        onSaved: onSaved,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obscureText ?? false,
        obscuringCharacter: '*',
        cursorColor: contentColor,
        maxLines: maxLines??1,
        validator: validator ??
            (value) {
              if (value?.isEmpty ?? true) {
                return AppStrings.thisFieldIsRequired;
              } else {
                return null;
              }
            },
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
              borderRadius: BorderRadius.circular(borderRadius ?? 16)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 16),
              borderSide: BorderSide(color: borderColor!)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 16),
              borderSide: BorderSide(
                color: borderColor!,
              )),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 16),
              borderSide: const BorderSide(
                color: Colors.red,
              )),
        ),
      ),
    );
  }
}

class AuthFooter extends StatelessWidget {
  const AuthFooter({
    super.key,
    required this.mainPhrase,
    required this.buttonTitle,
    this.onPressed,
  });
  final String mainPhrase;
  final String buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          mainPhrase,
          style: const TextStyle(color: AppColor.white),
        ),
        TextButton(
            onPressed: onPressed,
            child:
                Text(buttonTitle, style: const TextStyle(color: AppColor.pink)))
      ],
    );
  }
}
