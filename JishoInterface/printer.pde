class LeveledPrinter {
  ArrayList<String> strings;
  ArrayList<Integer> levels;
  int curlevel;
  LeveledPrinter() {
    strings = new ArrayList<String>();
    levels = new ArrayList<Integer>();
    curlevel = 0;
  }
  void levelIn() {
    curlevel++;
  }
  void levelOut() {
    curlevel--;
  }
  void addString(String s) {
    strings.add(s);
    levels.add(curlevel);
  }
  void printAll() {
    for (int i = 0; i < strings.size(); i++) {
      String padding = "";
      for (int j = 0; j < levels.get(i); j++) {
        padding += "|   ";
      }
      println(padding + strings.get(i));
    }
  }
  void showAll() {
    float textY = baseY;
    for (int i = 0; i < strings.size(); i++) {
      String padding = "";
      for (int j = 0; j < levels.get(i); j++) {
        padding += "|   ";
      }
      text(padding + strings.get(i), 10, textY);
      textY += 15;
    }
  }
}
