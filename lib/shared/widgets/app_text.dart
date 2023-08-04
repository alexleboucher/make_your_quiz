import 'package:flutter/material.dart';

enum Typo {
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
  const AppText(
    this.text, {
    this.typo = Typo.bodyMedium,
    this.textAlign,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    super.key,
  })  : numberOfLines = null,
        textSpan = null;

  const AppText.fixedMultiline(
    this.text, {
    this.typo = Typo.bodyMedium,
    this.textAlign,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.numberOfLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    super.key,
  })  : maxLines = null,
        textSpan = null;

  const AppText.rich(
    this.textSpan, {
    this.typo = Typo.bodyMedium,
    this.textAlign,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    super.key,
  })  : numberOfLines = null,
        text = null;

  final String? text;
  final InlineSpan? textSpan;
  final Typo typo;
  final TextAlign? textAlign;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  final int? numberOfLines;

  TextStyle _buildStyle({
    required Typo typo,
    required BuildContext context,
    required TextStyle? style,
  }) {
    final textTheme = Theme.of(context).textTheme;
    TextStyle? textStyle;
    switch (typo) {
      case Typo.displayLarge:
        textStyle = textTheme.displayLarge;
      case Typo.displayMedium:
        textStyle = textTheme.displayMedium;
      case Typo.displaySmall:
        textStyle = textTheme.displaySmall;
      case Typo.headlineLarge:
        textStyle = textTheme.headlineLarge;
      case Typo.headlineMedium:
        textStyle = textTheme.headlineMedium;
      case Typo.headlineSmall:
        textStyle = textTheme.headlineSmall;
      case Typo.titleLarge:
        textStyle = textTheme.titleLarge;
      case Typo.titleMedium:
        textStyle = textTheme.titleMedium;
      case Typo.titleSmall:
        textStyle = textTheme.titleSmall;
      case Typo.bodyLarge:
        textStyle = textTheme.bodyLarge;
      case Typo.bodyMedium:
        textStyle = textTheme.bodyMedium;
      case Typo.bodySmall:
        textStyle = textTheme.bodySmall;
      case Typo.labelLarge:
        textStyle = textTheme.labelLarge;
      case Typo.labelMedium:
        textStyle = textTheme.labelMedium;
      case Typo.labelSmall:
        textStyle = textTheme.labelSmall;
    }
    textStyle ??= const TextStyle();

    if (style == null) {
      return textStyle;
    }

    return textStyle.copyWith(
      inherit: style.inherit,
      color: style.color,
      backgroundColor: style.backgroundColor,
      fontSize: style.fontSize,
      fontWeight: style.fontWeight,
      fontStyle: style.fontStyle,
      letterSpacing: style.letterSpacing,
      wordSpacing: style.wordSpacing,
      textBaseline: style.textBaseline,
      height: style.height,
      leadingDistribution: style.leadingDistribution,
      locale: style.locale,
      foreground: style.foreground,
      background: style.background,
      shadows: style.shadows,
      fontFeatures: style.fontFeatures,
      fontVariations: style.fontVariations,
      decoration: style.decoration,
      decorationColor: style.decorationColor,
      decorationStyle: style.decorationStyle,
      decorationThickness: style.decorationThickness,
      debugLabel: style.debugLabel,
      fontFamily: style.fontFamily,
      fontFamilyFallback: style.fontFamilyFallback,
      overflow: style.overflow,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = _buildStyle(typo: typo, context: context, style: style);

    if (textSpan != null) {
      return Text.rich(
        textSpan!,
        style: textStyle,
        textAlign: textAlign,
        strutStyle: strutStyle,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaleFactor: textScaleFactor,
        maxLines: numberOfLines ?? maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      );
    }

    var textToUse = text!;
    if (numberOfLines != null) {
      final buffer = StringBuffer(text!);
      for (var i = 0; i < numberOfLines!; i++) {
        buffer.write('\n');
      }
      textToUse = buffer.toString();
    }

    return Text(
      textToUse,
      style: textStyle,
      textAlign: textAlign,
      strutStyle: strutStyle,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: numberOfLines ?? maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}
