String concatenateJapaneseArray(Japanese[] japanese) {
  String result = "";
  for (Japanese j : japanese) {
    if (j.word != null)
      result += j.word + " (" + j.reading + "), ";
    else
      result += j.reading + ", ";
  }
  result = result.substring(0, result.length() - 2);
  return result;
}

String concatenateStringArray(String[] array) {
  String result = "";
  for (String s : array)
    result += s + ", ";
  result = result.substring(0, result.length() - 2);
  return result;
}

void simpleAddWordToLeveledPrinter(Word word, LeveledPrinter printer, boolean includeSenses) {
  printer.addString(concatenateJapaneseArray(word.japanese));
  if (includeSenses) {
    printer.levelIn();
    Sense[] senses = word.senses;
    for (Sense sense : senses) {
      printer.addString(concatenateStringArray(sense.english_definitions));
    }
    printer.levelOut();
  }
}

void complexAddWordToLeveledPrinter(Word word, LeveledPrinter printer) {
  printer.addString("word");
  printer.levelIn();
  printer.addString("is_common: " + word.is_common);
    
  printer.addString("tags:");
  printer.addAllLeveling(word.tags);
  
  printer.addString("japanese:");
  printer.addAllLeveling(word.japanese);
  
  printer.addString("senses:");
  printer.levelIn();
  int i = 0;
  for (Sense s : word.senses) {
    printer.addString("sense " + i++ + ":");
    printer.levelIn();
    s.addToLeveledPrinter(printer);
    printer.levelOut();
  }
  printer.levelOut();
  printer.levelOut();
}
