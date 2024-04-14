class AppEntity {
  bool? isDarkMode;
  String? languageCode;
  AppEntity({
    this.isDarkMode,
    this.languageCode,
  });

  AppEntity copyWith({
    bool? isDarkMode,
    String? languageCode,
  }) {
    return AppEntity(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  @override
  String toString() => 'AppEntity(isDarkMode: $isDarkMode, languageCode: $languageCode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppEntity && other.isDarkMode == isDarkMode && other.languageCode == languageCode;
  }

  @override
  int get hashCode => isDarkMode.hashCode ^ languageCode.hashCode;
}
