import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart';

import '../../resources/index.dart';

final localesMap = <String, LookupMessages>{
  'am': AmMessages(),
  'ar': ArMessages(),
  'ar_short': ArShortMessages(),
  'az': AzMessages(),
  'be': BeMessages(),
  'bn': BnMessages(),
  'bn_short': BnShortMessages(),
  'bs': BsMessages(),
  'ca': CaMessages(),
  'cs': CsMessages(),
  'da': DaMessages(),
  'de': DeMessages(),
  'dv': DvMessages(),
  'es': EsMessages(),
  'et': EtMessages(),
  'et_short': EtShortMessages(),
  'fa': FaMessages(),
  'fi': FiMessages(),
  'fi_short': FiShortMessages(),
  'fr': FrMessages(),
  'gr': GrMessages(),
  'he': HeMessages(),
  'hi': HiShortMessages(),
  'hr': HrMessages(),
  'hu': HuMessages(),
  'id': IdMessages(),
  'id_short': IdShortMessages(),
  'it': ItMessages(),
  'ja': JaMessages(),
  'km': KmMessages(),
  'ko': KoMessages(),
  'ku': KuMessages(),
  'ku_short': KuShortMessages(),
  'lv': LvMessages(),
  'mn': MnMessages(),
  'mn_MY': MsMyMessages(),
  'ms_MY': MsMyMessages(),
  'my': MyMessages(),
  'nb_NO': NbNoMessages(),
  'nb_NO_short': NbNoShortMessages(),
  'nl': NlMessages(),
  'nn_NO': NnNoMessages(),
  'nn_NO_short': NnNoShortMessages(),
  'pl': PlMessages(),
  'pt_BR': PtBrMessages(),
  'pt_BR_short': PtBrShortMessages(),
  'ro': RoMessages(),
  'ro_short': RoShortMessages(),
  'ru': RuMessages(),
  'rw': RwMessages(),
  'sr': SrMessages(),
  'sv': SvMessages(),
  'ta': TaMessages(),
  'th': ThMessages(),
  'th_short': ThShortMessages(),
  'tk': TkMessages(),
  'tr': TrMessages(),
  'tr_short': TrShortMessages(),
  'uk': UkMessages(),
  'uk_short': UkShortMessages(),
  'ur': UrMessages(),
  'vi': ViMessages(),
  'zh': ZhMessages(),
  'zh_CN': ZhCnMessages(),
};

class Country {
  final String code;
  final String? language;

  Country({required this.code, this.language});
}

///ISO 639-1 Language Codes
///ISO 3166-1 Country Codes
Map<String, Country> languageToCountryCode = {
  'en': Country(code: 'US', language: 'English'), // English -> United States
  'fr': Country(code: 'FR', language: 'Français'), // French -> France
  'es': Country(code: 'ES', language: 'Español'), // Spanish -> Spain
  'de': Country(code: 'DE', language: 'Deutsch'), // German -> Germany
  'zh': Country(code: 'CN', language: '中文'), // Chinese -> China
  'ja': Country(code: 'JP', language: '日本語'), // Japanese -> Japan
  'ko': Country(code: 'KR', language: '한국어'), // Korean -> South Korea
  'ru': Country(code: 'RU', language: 'Русский'), // Russian -> Russia
  'it': Country(code: 'IT', language: 'Italiano'), // Italian -> Italy
  'pt': Country(code: 'PT', language: 'Português'), // Portuguese -> Portugal
  'ar': Country(code: 'SA', language: 'العربية'), // Arabic -> Saudi Arabia
  'hi': Country(code: 'IN', language: 'हिन्दी'), // Hindi -> India
  'th': Country(code: 'TH', language: 'ไทย'), // Thai -> Thailand
  'tr': Country(code: 'TR', language: 'Türkçe'), // Turkish -> Turkey
  'ms': Country(code: 'MY', language: 'Bahasa Melayu'), // Malay -> Malaysia
  'nl': Country(code: 'NL', language: 'Nederlands'), // Dutch -> Netherlands
  'pl': Country(code: 'PL', language: 'Polski'), // Polish -> Poland
  'sv': Country(code: 'SE', language: 'Svenska'), // Swedish -> Sweden
  'no': Country(code: 'NO', language: 'Norsk'), // Norwegian -> Norway
  'da': Country(code: 'DK', language: 'Dansk'), // Danish -> Denmark
  'fi': Country(code: 'FI', language: 'Suomi'), // Finnish -> Finland
  'cs': Country(code: 'CZ', language: 'Čeština'), // Czech -> Czech Republic
  'hu': Country(code: 'HU', language: 'Magyar'), // Hungarian -> Hungary
  'el': Country(code: 'GR', language: 'Ελληνικά'), // Greek -> Greece
  'he': Country(code: 'IL', language: 'עברית'), // Hebrew -> Israel
  'fa': Country(code: 'IR', language: 'فارسی'), // Persian -> Iran
  'id': Country(code: 'ID', language: 'Bahasa Indonesia'), // Indonesian -> Indonesia
  'ro': Country(code: 'RO', language: 'Română'), // Romanian -> Romania
  'uk': Country(code: 'UA', language: 'Українська'), // Ukrainian -> Ukraine
  'bg': Country(code: 'BG', language: 'Български'), // Bulgarian -> Bulgaria
  'sr': Country(code: 'RS', language: 'Српски'), // Serbian -> Serbia
  'sk': Country(code: 'SK', language: 'Slovenčina'), // Slovak -> Slovakia
  'sl': Country(code: 'SI', language: 'Slovenščina'), // Slovenian -> Slovenia
  'hr': Country(code: 'HR', language: 'Hrvatski'), // Croatian -> Croatia
  'lt': Country(code: 'LT', language: 'Lietuvių'), // Lithuanian -> Lithuania
  'lv': Country(code: 'LV', language: 'Latviešu'), // Latvian -> Latvia
  'et': Country(code: 'EE', language: 'Eesti'), // Estonian -> Estonia
  'is': Country(code: 'IS', language: 'Íslenska'), // Icelandic -> Iceland
  'mt': Country(code: 'MT', language: 'Malti'), // Maltese -> Malta
  'ga': Country(code: 'IE', language: 'Gaeilge'), // Irish -> Ireland
  'cy': Country(code: 'GB', language: 'Cymraeg'), // Welsh -> United Kingdom
  'eu': Country(code: 'ES', language: 'Euskara'), // Basque -> Spain
  'ca': Country(code: 'ES', language: 'Català'), // Catalan -> Spain
  'af': Country(code: 'ZA', language: 'Afrikaans'), // Afrikaans -> South Africa
  'sw': Country(code: 'KE', language: 'Kiswahili'), // Swahili -> Kenya
  'am': Country(code: 'ET', language: 'አማርኛ'), // Amharic -> Ethiopia
  'so': Country(code: 'SO', language: 'Af-Soomaali'), // Somali -> Somalia
  'ny': Country(code: 'MW', language: 'Chichewa'), // Chichewa -> Malawi
  'zu': Country(code: 'ZA', language: 'IsiZulu'), // Zulu -> South Africa
  'vi': Country(code: 'VN', language: 'Tiếng Việt'), // Vietnamese -> Vietnam
};

class S {
  S._(); // Private constructor
  static late final S _instance = S._(); // Lazy initialization
  static S get instance => _instance; // Getter to access the instance

  static late BuildContext? _context;
  static S of(BuildContext context) {
    _context = context;
    return _instance;
  }

  static AppString get current => AppString.of(_context!);

  void addLocaleTimeAgo() {
    localesMap.forEach((locale, lookupMessages) {
      setLocaleMessages(locale, lookupMessages);
    });
  }
}
