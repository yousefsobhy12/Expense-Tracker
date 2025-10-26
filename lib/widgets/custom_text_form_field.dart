import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.password = false,
    this.readOnly = false,
    this.maxLines = 1,
    this.validator,
    this.onTap,
    this.textInputAction = TextInputAction.done,
    this.onSubmitted,
    this.fillColor,
    this.autoFocus = false,
    this.onChanged,
    this.phoneNumber = false,
    this.isNumeric = false,
    this.errorText,
    this.suffixIcon,
  });

  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final bool readOnly;
  final int maxLines;
  final String? Function(String? value)? validator;
  final void Function()? onTap;
  final TextInputAction textInputAction;
  final void Function(String value)? onSubmitted;
  final Color? fillColor;
  final bool autoFocus;
  final bool password;
  final bool phoneNumber;
  final bool isNumeric; // Flag to check if this field should accept numbers
  final void Function(String value)? onChanged;
  final String? errorText;
  final Widget? suffixIcon;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isVisiblePassword = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return TextFormField(
      focusNode: _focusNode,
      obscureText: widget.password && !isVisiblePassword,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      // Decide keyboard type based on phone number or numeric input
      keyboardType: widget.phoneNumber
          ? TextInputType.phone
          : widget.isNumeric
          ? const TextInputType.numberWithOptions(
              decimal: true,
            ) // Numeric with decimals
          : TextInputType.text,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      inputFormatters: widget.phoneNumber
          ? [
              FilteringTextInputFormatter.digitsOnly,
            ] // Only digits for phone number
          : widget.isNumeric
          ? [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
            ] // Allow digits and decimals for weight
          : null,
      autofocus: widget.autoFocus,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      controller: widget.controller,
      onFieldSubmitted: widget.onSubmitted,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        fillColor: widget.fillColor ?? Colors.grey.shade100,
        filled: true,
        hintText: widget.hint,
        errorText: widget.errorText,
        enabledBorder: border(),
        focusedBorder: border(),
        disabledBorder: border(),
        errorBorder: errorBorder(),
        focusedErrorBorder: errorBorder(),
      ),
    );
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: Color(0xffCCBEAE)),
    );
  }

  OutlineInputBorder errorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: Colors.red),
    );
  }
}
