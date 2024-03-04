import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';

class NoteTextFormField extends StatelessWidget {
  const NoteTextFormField({
    super.key,
    required this.titleController,
    this.maxLines,
    this.hint, this.errorText, this.onChanged,
  });

  final TextEditingController titleController;
  final int? maxLines;
  final String? hint;
  final String? errorText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: titleController,
      keyboardType: TextInputType.text,
      cursorColor: AppColor.grey,
      maxLines: maxLines,
      onChanged: onChanged,
      
      decoration: InputDecoration(
        hintText: hint,
        errorText:errorText ,
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
