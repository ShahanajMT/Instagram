import 'package:flutter/material.dart';

class TextInputFeild extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType textInputType;
  final bool isPass;
  const TextInputFeild({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.textInputType,
    this.isPass = false,
  });

  @override
  Widget build(BuildContext context) {
    //Border
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));

    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
