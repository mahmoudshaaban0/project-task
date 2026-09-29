/// Masking for data shown before device auth succeeds.
///
/// Masks have a fixed length: `A•••• K.` whether the name is "Al" or
/// "Bartholomew", and `AED ••,•••.••` whether the amount is 5 or 50,000.
/// A mask that grew with the value would leak its length (and so roughly how
/// much money is involved).
const maskChar = '•';

const _nameMaskLength = 4;

/// `Ahmed Khalid` → `A•••• K.`, `Leo` → `L••••`.
///
/// Keeps only the first character of the first and last words. Middle names
/// are dropped. Works on runes so Arabic names mask the same way.
String maskName(String name) {
  final words = name
      .trim()
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .toList();
  if (words.isEmpty) return maskChar * _nameMaskLength;

  final first = '${_firstChar(words.first)}${maskChar * _nameMaskLength}';
  if (words.length == 1) return first;
  return '$first ${_firstChar(words.last)}.';
}

/// `AED ••,•••.••` for every amount, with the currency's own number of
/// decimal places.
String maskAmount({String currency = 'AED'}) =>
    '$currency ${maskChar * 2},${maskChar * 3}.${maskChar * 2}';

String _firstChar(String word) => String.fromCharCode(word.runes.first);
