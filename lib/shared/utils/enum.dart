import 'package:dartx/dartx.dart';

import '../index.dart';

// Example:
// static String mapGenderToText(Gender gender) {
//   switch (gender) {
//     case Gender.unknown:
//       return '';
//     case Gender.male:
//       return S.current.re1_male;
//     case Gender.female:
//       return S.current.re1_female;
//     case Gender.other:
//       return S.current.re1_other;
//   }
// }

enum Flavor { dev, stg, prod }

enum DeviceType { mobile, tablet }

enum ErrorResponseMapperType {
  jsonObject,
  jsonArray,
  line,
  twitter,
  firebaseStorage,
}

enum SuccessResponseMapperType {
  dataJsonObject,
  dataJsonArray,
  jsonObject,
  jsonArray,
  recordsJsonArray,
  resultsJsonArray,
  plain,
}

enum LanguageCode {
  en(
    localeCode: 'en',
    value: Constant.en,
  ),
  ja(
    localeCode: 'ja',
    value: Constant.ja,
  );

  const LanguageCode({required this.localeCode, required this.value});

  factory LanguageCode.fromValue(String? data) {
    return values.firstOrNullWhere((element) => element.value == data) ?? defaultValue;
  }

  final String localeCode;
  final String value;

  static const defaultValue = en;
}
