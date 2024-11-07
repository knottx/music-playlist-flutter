import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:music_playlist/routes/extra_data.dart';

class ExtraCodec extends Codec<ExtraData?, String?> {
  const ExtraCodec();

  @override
  Converter<String?, ExtraData?> get decoder {
    return const ExtraDecoder();
  }

  @override
  Converter<ExtraData?, String?> get encoder {
    return const ExtraEncoder();
  }
}

class ExtraDecoder extends Converter<String?, ExtraData?> {
  const ExtraDecoder();

  @override
  ExtraData? convert(String? input) {
    if (input == null) return null;
    try {
      return ExtraData.fromJson(jsonDecode(input));
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw FormatException('Unable to parse input: $input');
    }
  }
}

class ExtraEncoder extends Converter<ExtraData?, String?> {
  const ExtraEncoder();
  @override
  String? convert(ExtraData? input) {
    if (input == null) return null;
    try {
      return jsonEncode(input.toJson());
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw FormatException('Cannot encode type ${input.runtimeType}');
    }
  }
}
