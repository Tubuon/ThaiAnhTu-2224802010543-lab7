import 'dart:collection';
import 'dart:math';

const List<String> allLegalGuesses = [...legalWords, ...legalGuesses];
const defaultNumGuesses = 5;

enum HitType { none, hit, partial, miss, removed }

typedef Letter = ({String char, HitType type});

const legalWords = <String>["aback", "abase", "abate", "abbey", "abbot"];

const legalGuesses = <String>[
  "aback", "abase", "abate", "abbey", "abbot",
  "abhor", "abide", "abled", "abode", "abort",
];

class Game {
  Game({this.numAllowedGuesses = defaultNumGuesses, this.seed}) {
    _wordToGuess = seed == null ? Word.random() : Word.fromSeed(seed!);
    _guesses = List<Word>.filled(numAllowedGuesses, Word.empty());
  }

  late final int numAllowedGuesses;
  late List<Word> _guesses;
  late Word _wordToGuess;
  int? seed;

  Word get hiddenWord => _wordToGuess;
  UnmodifiableListView<Word> get guesses => UnmodifiableListView(_guesses);

  Word get previousGuess {
    final index = _guesses.lastIndexWhere((word) => word.isNotEmpty);
    return index == -1 ? Word.empty() : _guesses[index];
  }

  int get activeIndex => _guesses.indexWhere((word) => word.isEmpty);

  int get guessesRemaining {
    if (activeIndex == -1) return 0;
    return numAllowedGuesses - activeIndex;
  }

  void resetGame() {
    _wordToGuess = seed == null ? Word.random() : Word.fromSeed(seed!);
    _guesses = List.filled(numAllowedGuesses, Word.empty());
  }

  Word guess(String guess) {
    final result = matchGuessOnly(guess);
    addGuessToList(result);
    return result;
  }

  bool get didWin {
    if (_guesses.first.isEmpty) return false;
    for (var letter in previousGuess) {
      if (letter.type != HitType.hit) return false;
    }
    return true;
  }

  bool get didLose => guessesRemaining == 0 && !didWin;

  bool isLegalGuess(String guess) => Word.fromString(guess).isLegalGuess;

  Word matchGuessOnly(String guess) {
    var hiddenCopy = Word.fromString(_wordToGuess.toString());
    return Word.fromString(guess).evaluateGuess(hiddenCopy);
  }

  void addGuessToList(Word guess) {
    final i = _guesses.indexWhere((word) => word.isEmpty);
    _guesses[i] = guess;
  }
}

class Word with IterableMixin<Letter> {
  Word(this._letters);

  factory Word.empty() => Word(List.filled(5, (char: '', type: HitType.none)));

  factory Word.fromString(String guess) {
    var list = guess.toLowerCase().split('');
    var letters = list.map((String char) => (char: char, type: HitType.none)).toList();
    return Word(letters);
  }

  factory Word.random() {
    var rand = Random();
    var nextWord = legalWords[rand.nextInt(legalWords.length)];
    return Word.fromString(nextWord);
  }

  factory Word.fromSeed(int seed) => Word.fromString(legalWords[seed % legalWords.length]);

  final List<Letter> _letters;

  @override
  Iterator<Letter> get iterator => _letters.iterator;

  @override
  bool get isEmpty => every((letter) => letter.char.isEmpty);

  @override
  bool get isNotEmpty => !isEmpty;

  Letter operator [](int i) => _letters[i];
  operator []=(int i, Letter value) => _letters[i] = value;

  @override
  String toString() => _letters.map((Letter c) => c.char).join().trim();
}

extension WordUtils on Word {
  bool get isLegalGuess => allLegalGuesses.contains(toString());

  Word evaluateGuess(Word other) {
    for (var i = 0; i < length; i++) {
      if (other[i].char == this[i].char) {
        this[i] = (char: this[i].char, type: HitType.hit);
        other[i] = (char: other[i].char, type: HitType.removed);
      }
    }
    for (var i = 0; i < other.length; i++) {
      Letter targetLetter = other[i];
      if (targetLetter.type != HitType.none) continue;
      for (var j = 0; j < length; j++) {
        Letter guessedLetter = this[j];
        if (guessedLetter.type != HitType.none) continue;
        if (guessedLetter.char == targetLetter.char) {
          this[j] = (char: guessedLetter.char, type: HitType.partial);
          other[i] = (char: targetLetter.char, type: HitType.removed);
          break;
        }
      }
    }
    for (var i = 0; i < length; i++) {
      if (this[i].type == HitType.none) {
        this[i] = (char: this[i].char, type: HitType.miss);
      }
    }
    return this;
  }
}