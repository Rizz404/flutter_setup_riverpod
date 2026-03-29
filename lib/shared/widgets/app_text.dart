import 'package:flutter/material.dart';
import 'package:flutter_setup_riverpod/core/extensions/theme_extension.dart';

enum AppTextStyle {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
}

class AppText extends StatelessWidget {
  final String text;
  final AppTextStyle? style;

  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  final TextStyle? customStyle;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? lineHeight;
  final TextDecoration? decoration;

  const AppText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    this.customStyle,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.lineHeight,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    TextStyle getBaseStyle() {
      final selectedStyle = style ?? AppTextStyle.bodyMedium;

      switch (selectedStyle) {
        case AppTextStyle.displayLarge:
          return textTheme.displayLarge!;
        case AppTextStyle.displayMedium:
          return textTheme.displayMedium!;
        case AppTextStyle.displaySmall:
          return textTheme.displaySmall!;
        case AppTextStyle.headlineLarge:
          return textTheme.headlineLarge!;
        case AppTextStyle.headlineMedium:
          return textTheme.headlineMedium!;
        case AppTextStyle.headlineSmall:
          return textTheme.headlineSmall!;
        case AppTextStyle.titleLarge:
          return textTheme.titleLarge!;
        case AppTextStyle.titleMedium:
          return textTheme.titleMedium!;
        case AppTextStyle.titleSmall:
          return textTheme.titleSmall!;
        case AppTextStyle.bodyLarge:
          return textTheme.bodyLarge!;
        case AppTextStyle.bodyMedium:
          return textTheme.bodyMedium!;
        case AppTextStyle.bodySmall:
          return textTheme.bodySmall!;
        case AppTextStyle.labelLarge:
          return textTheme.labelLarge!;
        case AppTextStyle.labelMedium:
          return textTheme.labelMedium!;
        case AppTextStyle.labelSmall:
          return textTheme.labelSmall!;
      }
    }

    TextStyle baseStyle = getBaseStyle();

    if (customStyle != null) {
      baseStyle = baseStyle.merge(customStyle);
    }

    final finalStyle = baseStyle.copyWith(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      height: lineHeight,
      decoration: decoration,
    );

    return Text(
      text,
      style: finalStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}
