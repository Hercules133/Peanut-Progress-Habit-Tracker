/// A model class representing a language with its properties such as
/// ID, flag, name, and language code.
class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  /// Constructs a [Language] object with the provided [id], [flag], [name],
  /// and [languageCode].
  Language(this.id, this.flag, this.name, this.languageCode);

  /// Returns a list of predefined [Language] objects.
  ///
  /// The list contains:
  /// - English (`en`), with the flag 🇺🇸
  /// - Deutsch (`de`), with the flag 🇩🇪
  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇺🇸", "English", "en"),
      Language(2, "🇩🇪", "Deutsch", "de"),
    ];
  }
}
