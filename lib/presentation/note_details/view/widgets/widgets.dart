import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';

class DetailsTextFormField extends StatelessWidget {
  const DetailsTextFormField({
    super.key,
    required this.titleController,
    this.maxLines,
  });

  final TextEditingController titleController;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: titleController,
      keyboardType: TextInputType.text,
      cursorColor: AppColor.grey,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColor.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColor.grey,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColor.red,
            )),
      ),
    );
  }
}
