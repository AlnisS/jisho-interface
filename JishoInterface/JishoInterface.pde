Word[] words;
float baseY = 0;
float targetBaseY = 0;

void setup() {
  size(400, 400);
  println("loading...\n");
  JSONObject page = loadJSONObject("https://jisho.org/api/v1/search/words?keyword=door");
  words = loadFromJSONArray(page.getJSONArray("data"));
}

void draw() {
  baseY = .7 * baseY + .3 * targetBaseY;
  fill(255);
  background(0);
  
  LeveledPrinter printer = new LeveledPrinter();
  //printer.addString("word 0:");
  //words[0].addToLeveledPrinter(printer);
  int i = 0;
  for (Word word : words) {
    simpleAddWordToLeveledPrinter(word, printer, i++ == 1);
  }
  //printer.printAll();
  printer.showAll();
}

void mouseWheel(MouseEvent event) {
  targetBaseY -= 10 * event.getCount();
}
