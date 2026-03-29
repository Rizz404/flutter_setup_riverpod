import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_setup_riverpod/core/extensions/theme_extension.dart';

enum AppTextFieldType {
  email,
  password,
  text,
  phone,
  number,
  price,
  url,
  multiline,
  hidden,
}

class AppTextField extends StatefulWidget {
  final String name;
  final String? initialValue;
  final String label;
  final String? placeHolder;
  final AppTextFieldType type;
  final int? maxLines;
  final String? Function(String?)? validator;
  final bool enableAutoCapitalization;
  final bool readOnly;
  final String? prefixText;
  final String? suffixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String?)? onChanged;
  final bool? enabled;

  const AppTextField({
    super.key,
    required this.name,
    this.initialValue,
    required this.label,
    this.placeHolder,
    this.type = AppTextFieldType.text,
    this.maxLines,
    this.validator,
    this.enableAutoCapitalization = true,
    this.readOnly = false,
    this.prefixText,
    this.suffixText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.enabled,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.type == AppTextFieldType.password;
    final isHidden = widget.type == AppTextFieldType.hidden;
    final isMultiline =
        widget.type == AppTextFieldType.multiline ||
        (widget.maxLines != null && widget.maxLines! > 1);

    if (isHidden) {
      return SizedBox(
        height: 0,
        child: FormBuilderTextField(
          name: widget.name,
          initialValue: widget.initialValue,
          validator: widget.validator,
          onChanged: widget.onChanged,
          style: const TextStyle(height: 0, fontSize: 0),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            constraints: BoxConstraints(maxHeight: 0, maxWidth: 0),
          ),
        ),
      );
    }

    TextInputType getKeyboardType() {
      switch (widget.type) {
        case AppTextFieldType.email:
          return TextInputType.emailAddress;
        case AppTextFieldType.phone:
          return TextInputType.phone;
        case AppTextFieldType.number:
        case AppTextFieldType.price:
          return TextInputType.number;
        case AppTextFieldType.url:
          return TextInputType.url;
        case AppTextFieldType.multiline:
          return TextInputType.multiline;
        default:
          return TextInputType.text;
      }
    }

    TextCapitalization getTextCapitalization() {
      if (!widget.enableAutoCapitalization) return TextCapitalization.none;

      switch (widget.type) {
        case AppTextFieldType.email:
        case AppTextFieldType.password:
        case AppTextFieldType.phone:
        case AppTextFieldType.number:
        case AppTextFieldType.price:
        case AppTextFieldType.url:
          return TextCapitalization.none;
        default:
          return TextCapitalization.sentences;
      }
    }

    List<TextInputFormatter> getInputFormatters() {
      switch (widget.type) {
        case AppTextFieldType.number:
          return [FilteringTextInputFormatter.digitsOnly];
        case AppTextFieldType.price:
          return [FilteringTextInputFormatter.digitsOnly, _YenPriceFormatter()];
        case AppTextFieldType.phone:
          return [FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-\s\(\)]'))];
        default:
          return [];
      }
    }

    String? getPrefixText() {
      if (widget.prefixText != null) return widget.prefixText;

      switch (widget.type) {
        case AppTextFieldType.price:
          return '¥';
        default:
          return null;
      }
    }

    String? formattedInitialValue = widget.initialValue;
    if (widget.type == AppTextFieldType.price && widget.initialValue != null) {
      formattedInitialValue = _YenPriceFormatter.formatPrice(
        widget.initialValue!,
      );
    }

    return FormBuilderTextField(
      name: widget.name,
      initialValue: formattedInitialValue,
      maxLines: isPassword ? 1 : (widget.maxLines ?? (isMultiline ? 5 : 1)),
      obscureText: isPassword ? _obscureText : false,
      keyboardType: getKeyboardType(),
      textCapitalization: getTextCapitalization(),
      inputFormatters: getInputFormatters(),
      readOnly: widget.readOnly,
      valueTransformer: (value) => value?.trim(),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.placeHolder,
        prefixText: getPrefixText(),
        suffixText: widget.suffixText,
        prefixIcon: widget.prefixIcon,
        suffixIcon:
            widget.suffixIcon ??
            (isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null),
        filled: true,
        fillColor: context.colors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.colors.border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.colors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.colors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.semantic.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.semantic.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      validator: widget.validator,
      enabled: widget.enabled ?? true,
    );
  }
}

class _YenPriceFormatter extends TextInputFormatter {
  static String formatPrice(String value) {
    if (value.isEmpty) return value;

    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.isEmpty) return '';

    return _addDots(digitsOnly);
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    String newText = newValue.text;
    int cursorIndex = newValue.selection.end;

    int digitsBeforeCursor = 0;
    for (int i = 0; i < cursorIndex && i < newText.length; i++) {
      if (RegExp(r'\d').hasMatch(newText[i])) {
        digitsBeforeCursor++;
      }
    }

    String digitsOnly = newText.replaceAll(RegExp(r'[^\d]'), '');
    String formatted = _addDots(digitsOnly);

    int newCursorIndex = 0;
    int digitsEncountered = 0;

    for (int i = 0; i < formatted.length; i++) {
      if (digitsEncountered == digitsBeforeCursor) {
        break;
      }
      if (RegExp(r'\d').hasMatch(formatted[i])) {
        digitsEncountered++;
      }
      newCursorIndex++;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newCursorIndex),
    );
  }

  static String _addDots(String value) {
    if (value.length <= 3) return value;

    String result = '';
    int count = 0;

    for (int i = value.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) {
        result = '.$result';
      }
      result = value[i] + result;
      count++;
    }

    return result;
  }
}
