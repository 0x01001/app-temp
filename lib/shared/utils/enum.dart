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

// enum LanguageCode {
//   en(code: 'en', countryCode: 'US'),
//   ja(code: 'ja', countryCode: 'JP');

//   const LanguageCode({required this.code, required this.countryCode});

//   factory LanguageCode.fromValue(String? data) {
//     return values.firstOrNullWhere((element) => element.countryCode == data) ?? defaultValue;
//   }

//   final String code;
//   final String countryCode;

//   static const defaultValue = en;
// }

enum ResourceType {
  comick,
  mangadex,
}

extension ResourceTypeExtension on ResourceType {
  int get id {
    switch (this) {
      case ResourceType.comick:
        return 1;
      case ResourceType.mangadex:
        return 2;
      default:
        return 0;
    }
  }
}
