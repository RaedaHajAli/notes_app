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
Padding buildLable(String title) {
  return Padding(
    padding: const EdgeInsets.only(left: 8, bottom: 5),
    child: Text(
      title,
      style: TextStyle(color: AppColor.white.withOpacity(0.7), fontSize: 14),
    ),
  );
}
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
    {
      // required TextEditingController controller,
      TextEditingController? controller,
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