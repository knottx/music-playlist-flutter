/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/cover_a.jpg
  AssetGenImage get coverA => const AssetGenImage('assets/images/cover_a.jpg');

  /// File path: assets/images/cover_b.jpg
  AssetGenImage get coverB => const AssetGenImage('assets/images/cover_b.jpg');

  /// File path: assets/images/cover_c.png
  AssetGenImage get coverC => const AssetGenImage('assets/images/cover_c.png');

  /// List of all assets
  List<AssetGenImage> get values => [coverA, coverB, coverC];
}

class $AssetsMusicsGen {
  const $AssetsMusicsGen();

  /// File path: assets/musics/01.mp3
  String get a01 => 'assets/musics/01.mp3';

  /// File path: assets/musics/02.mp3
  String get a02 => 'assets/musics/02.mp3';

  /// File path: assets/musics/03.mp3
  String get a03 => 'assets/musics/03.mp3';

  /// File path: assets/musics/04.mp3
  String get a04 => 'assets/musics/04.mp3';

  /// File path: assets/musics/05.mp3
  String get a05 => 'assets/musics/05.mp3';

  /// File path: assets/musics/06.mp3
  String get a06 => 'assets/musics/06.mp3';

  /// File path: assets/musics/07.mp3
  String get a07 => 'assets/musics/07.mp3';

  /// File path: assets/musics/08.mp3
  String get a08 => 'assets/musics/08.mp3';

  /// File path: assets/musics/09.mp3
  String get a09 => 'assets/musics/09.mp3';

  /// File path: assets/musics/10.mp3
  String get a10 => 'assets/musics/10.mp3';

  /// File path: assets/musics/11.mp3
  String get a11 => 'assets/musics/11.mp3';

  /// File path: assets/musics/12.mp3
  String get a12 => 'assets/musics/12.mp3';

  /// File path: assets/musics/13.mp3
  String get a13 => 'assets/musics/13.mp3';

  /// File path: assets/musics/14.mp3
  String get a14 => 'assets/musics/14.mp3';

  /// List of all assets
  List<String> get values =>
      [a01, a02, a03, a04, a05, a06, a07, a08, a09, a10, a11, a12, a13, a14];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsMusicsGen musics = $AssetsMusicsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}