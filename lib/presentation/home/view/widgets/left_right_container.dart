import 'package:flutter/material.dart';
import 'package:fullnoteapp/presentation/resources/color_manager.dart';





 

final leftEditIcon = Container(
      decoration: const BoxDecoration(
        color: AppColor.grey,
      ),
      alignment: Alignment.centerLeft,
      child: const Icon(
        Icons.edit,
        color: Colors.white,
      ),
    );
      final rightDeleteIcon = Container(
      decoration: const BoxDecoration(
        color: AppColor.red,
      ),
      alignment: Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );