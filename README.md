# Rule based English to Ukrainian translator

Very simple translator. Barely handles Present Continious.

Currently it doesn't because of unimplemented dictionary interface.
The declension part is also undone.

Thinking about writing it in Python and to make it much simpler.

## Dependencies
- `amb-parser` (it's my package actually).

## Algorithm:
1. Parse English sentence into parse tree (`parsing.rkt`, `english-grammar.rkt`, `dictionary.rkt`):
  1. Downcase string.
  2. Remove punctuation characters.
  3. Split string into words by whitespace.
  4. Tag POS for words.
  5. Parse the sentence. (`amb-parser` handles ambiguity, so it returns all possible parse trees).
2. Transform English parse tree into Ukrainian parse tree.
  That's the heart of the translator. It uses rules and Racket's `match` form to transform English grammar patterns to Ukrainian grammar patterns.

  The only thing it handles are:
  - Removing `am`, `is`, `are` from simple sentences (like: `My name is Anton.`).
  - Removing determiners `a`, `an`, `the`.
  - Transforming sentences with `have`/`has` (like: `I have a pen.` -> `В я є ручка`).
3. Decline Ukrainian parse tree and turn it into string.
  It should be an interesing part of the program. I've tried to write declension functions some time ago, but failed.
