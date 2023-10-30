class DictionaryEntry {
  final String word;
  final Pronunciation pronunciation;
  final List<Meaning> meanings;
  final List<String> examples;
  bool inHistory;
  bool inFavorite;

  DictionaryEntry({
    required this.word,
    required this.pronunciation,
    required this.meanings,
    required this.examples,
  })  : inHistory = false,
        inFavorite = false;

  factory DictionaryEntry.fromJson(Map<String, dynamic> json) {
    return DictionaryEntry(
        word: json['word'] ?? '',
        pronunciation: Pronunciation.fromJson(json['pronunciation']),
        meanings: List<Meaning>.from(
          json['meaning'].map((meaning) => Meaning.fromJson(meaning)),
        ),
        examples: List<String>.from(json['examples']));
  }

  @override
  bool operator ==(covariant DictionaryEntry other) => word == other.word;

  @override
  int get hashCode => word.hashCode;
}

class Pronunciation {
  final String ipa;
  final String audio;

  Pronunciation({required this.ipa, required this.audio});

  factory Pronunciation.fromJson(Map<String, dynamic> json) {
    return Pronunciation(
      ipa: json['ipa'] ?? '',
      audio: json['audio'] ?? '',
    );
  }
}

class Meaning {
  final String tag;
  final List<String> values;

  Meaning({required this.tag, required this.values});

  factory Meaning.fromJson(Map<String, dynamic> json) {
    return Meaning(
      tag: json['tag'] ?? '',
      values: List<String>.from(json['values']),
    );
  }
}
