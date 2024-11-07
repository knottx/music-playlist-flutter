import 'package:flutter/material.dart';

class AppTheme {
  final TextTheme textTheme;

  const AppTheme({
    this.textTheme = const TextTheme(),
  });

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff436833),
      surfaceTint: Color(0xff436833),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffc4efac),
      onPrimaryContainer: Color(0xff062100),
      secondary: Color(0xff55624c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd8e7cb),
      onSecondaryContainer: Color(0xff131f0d),
      tertiary: Color(0xff386667),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffbbebec),
      onTertiaryContainer: Color(0xff002021),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff8faf0),
      onSurface: Color(0xff191d17),
      onSurfaceVariant: Color(0xff43483e),
      outline: Color(0xff73796e),
      outlineVariant: Color(0xffc3c8bb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e312b),
      inversePrimary: Color(0xffa9d292),
      primaryFixed: Color(0xffc4efac),
      onPrimaryFixed: Color(0xff062100),
      primaryFixedDim: Color(0xffa9d292),
      onPrimaryFixedVariant: Color(0xff2c4f1d),
      secondaryFixed: Color(0xffd8e7cb),
      onSecondaryFixed: Color(0xff131f0d),
      secondaryFixedDim: Color(0xffbccbb0),
      onSecondaryFixedVariant: Color(0xff3d4b36),
      tertiaryFixed: Color(0xffbbebec),
      onTertiaryFixed: Color(0xff002021),
      tertiaryFixedDim: Color(0xffa0cfd0),
      onTertiaryFixedVariant: Color(0xff1e4e4f),
      surfaceDim: Color(0xffd9dbd1),
      surfaceBright: Color(0xfff8faf0),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f5ea),
      surfaceContainer: Color(0xffedefe5),
      surfaceContainerHigh: Color(0xffe7e9df),
      surfaceContainerHighest: Color(0xffe1e4d9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff284b1a),
      surfaceTint: Color(0xff436833),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff597e47),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff3a4732),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6b7961),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff194a4b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff4f7c7d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff8faf0),
      onSurface: Color(0xff191d17),
      onSurfaceVariant: Color(0xff3f443b),
      outline: Color(0xff5b6156),
      outlineVariant: Color(0xff777c71),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e312b),
      inversePrimary: Color(0xffa9d292),
      primaryFixed: Color(0xff597e47),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff416530),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6b7961),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff52604a),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff4f7c7d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff356364),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd9dbd1),
      surfaceBright: Color(0xfff8faf0),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f5ea),
      surfaceContainer: Color(0xffedefe5),
      surfaceContainerHigh: Color(0xffe7e9df),
      surfaceContainerHighest: Color(0xffe1e4d9),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff082900),
      surfaceTint: Color(0xff436833),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff284b1a),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff192513),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff3a4732),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff002728),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff194a4b),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff8faf0),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff20251d),
      outline: Color(0xff3f443b),
      outlineVariant: Color(0xff3f443b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e312b),
      inversePrimary: Color(0xffcdf9b5),
      primaryFixed: Color(0xff284b1a),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff123405),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff3a4732),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff24301d),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff194a4b),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003334),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd9dbd1),
      surfaceBright: Color(0xfff8faf0),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f5ea),
      surfaceContainer: Color(0xffedefe5),
      surfaceContainerHigh: Color(0xffe7e9df),
      surfaceContainerHighest: Color(0xffe1e4d9),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa9d292),
      surfaceTint: Color(0xffa9d292),
      onPrimary: Color(0xff163808),
      primaryContainer: Color(0xff2c4f1d),
      onPrimaryContainer: Color(0xffc4efac),
      secondary: Color(0xffbccbb0),
      onSecondary: Color(0xff273421),
      secondaryContainer: Color(0xff3d4b36),
      onSecondaryContainer: Color(0xffd8e7cb),
      tertiary: Color(0xffa0cfd0),
      onTertiary: Color(0xff003738),
      tertiaryContainer: Color(0xff1e4e4f),
      onTertiaryContainer: Color(0xffbbebec),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff11140f),
      onSurface: Color(0xffe1e4d9),
      onSurfaceVariant: Color(0xffc3c8bb),
      outline: Color(0xff8d9287),
      outlineVariant: Color(0xff43483e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e4d9),
      inversePrimary: Color(0xff436833),
      primaryFixed: Color(0xffc4efac),
      onPrimaryFixed: Color(0xff062100),
      primaryFixedDim: Color(0xffa9d292),
      onPrimaryFixedVariant: Color(0xff2c4f1d),
      secondaryFixed: Color(0xffd8e7cb),
      onSecondaryFixed: Color(0xff131f0d),
      secondaryFixedDim: Color(0xffbccbb0),
      onSecondaryFixedVariant: Color(0xff3d4b36),
      tertiaryFixed: Color(0xffbbebec),
      onTertiaryFixed: Color(0xff002021),
      tertiaryFixedDim: Color(0xffa0cfd0),
      onTertiaryFixedVariant: Color(0xff1e4e4f),
      surfaceDim: Color(0xff11140f),
      surfaceBright: Color(0xff373a33),
      surfaceContainerLowest: Color(0xff0c0f0a),
      surfaceContainerLow: Color(0xff191d17),
      surfaceContainer: Color(0xff1d211a),
      surfaceContainerHigh: Color(0xff282b24),
      surfaceContainerHighest: Color(0xff32362f),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffadd796),
      surfaceTint: Color(0xffa9d292),
      onPrimary: Color(0xff041b00),
      primaryContainer: Color(0xff749b60),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffc0cfb4),
      onSecondary: Color(0xff0e1908),
      secondaryContainer: Color(0xff87957c),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffa4d3d4),
      onTertiary: Color(0xff001a1b),
      tertiaryContainer: Color(0xff6b999a),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff11140f),
      onSurface: Color(0xfff9fcf1),
      onSurfaceVariant: Color(0xffc7cdbf),
      outline: Color(0xff9fa598),
      outlineVariant: Color(0xff808579),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e4d9),
      inversePrimary: Color(0xff2d501e),
      primaryFixed: Color(0xffc4efac),
      onPrimaryFixed: Color(0xff031500),
      primaryFixedDim: Color(0xffa9d292),
      onPrimaryFixedVariant: Color(0xff1c3e0e),
      secondaryFixed: Color(0xffd8e7cb),
      onSecondaryFixed: Color(0xff091405),
      secondaryFixedDim: Color(0xffbccbb0),
      onSecondaryFixedVariant: Color(0xff2d3a26),
      tertiaryFixed: Color(0xffbbebec),
      onTertiaryFixed: Color(0xff001415),
      tertiaryFixedDim: Color(0xffa0cfd0),
      onTertiaryFixedVariant: Color(0xff073d3e),
      surfaceDim: Color(0xff11140f),
      surfaceBright: Color(0xff373a33),
      surfaceContainerLowest: Color(0xff0c0f0a),
      surfaceContainerLow: Color(0xff191d17),
      surfaceContainer: Color(0xff1d211a),
      surfaceContainerHigh: Color(0xff282b24),
      surfaceContainerHighest: Color(0xff32362f),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff2ffe5),
      surfaceTint: Color(0xffa9d292),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffadd796),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff2ffe5),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffc0cfb4),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffe9ffff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffa4d3d4),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff11140f),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff8fdef),
      outline: Color(0xffc7cdbf),
      outlineVariant: Color(0xffc7cdbf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e4d9),
      inversePrimary: Color(0xff0f3103),
      primaryFixed: Color(0xffc8f3b0),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffadd796),
      onPrimaryFixedVariant: Color(0xff041b00),
      secondaryFixed: Color(0xffddeccf),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc0cfb4),
      onSecondaryFixedVariant: Color(0xff0e1908),
      tertiaryFixed: Color(0xffc0f0f1),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffa4d3d4),
      onTertiaryFixedVariant: Color(0xff001a1b),
      surfaceDim: Color(0xff11140f),
      surfaceBright: Color(0xff373a33),
      surfaceContainerLowest: Color(0xff0c0f0a),
      surfaceContainerLow: Color(0xff191d17),
      surfaceContainer: Color(0xff1d211a),
      surfaceContainerHigh: Color(0xff282b24),
      surfaceContainerHighest: Color(0xff32362f),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
