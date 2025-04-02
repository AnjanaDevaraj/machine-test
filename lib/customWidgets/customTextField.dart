import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final double? height;
  final double? margin;
  final bool? readonly;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final Future<void> Function(String)? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final bool? obscureText;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.hintText,
    this.prefixIcon,
    this.height,
    this.margin,
    this.readonly,
    this.textInputAction,
    this.onEditingComplete,
    this.onSubmitted,
    this.onChanged,
    this.obscureText,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 36,
      margin: EdgeInsets.symmetric(horizontal: margin ?? 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.black.withOpacity(0.2),
        ),
      ),
      child: TextField(
        maxLines: maxLines,
        obscureText: obscureText ?? false,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        readOnly: readonly ?? false,
        onSubmitted: onSubmitted,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        onEditingComplete: () async {
          if (onEditingComplete != null) {
            await onEditingComplete!(controller.text);
          }
          FocusScope.of(context).unfocus();
        },
        controller: controller,
        style: const TextStyle(color: Colors.black, fontSize: 14),
        decoration: InputDecoration(
          prefixIcon: prefixIcon ?? const Icon(Icons.person, color: Colors.grey),
          hintText: hintText ?? '',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          suffixIcon: obscureText != null
              ? IconButton(
            icon: Icon(
              obscureText! ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              //Provider.of<LoginProvider>(context, listen: false).toggleObscureText();
            },
          )
              : null,
        ),
      ),
    );
  }
}
