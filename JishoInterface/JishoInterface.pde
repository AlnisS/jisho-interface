Word[] words;
float baseY = 0;
float targetBaseY = 0;

void setup() {
  size(600, 600);
  println("loading...\n");
  JSONObject page = loadJSONObject("https://jisho.org/api/v1/search/words?keyword=door");
  words = loadFromJSONArray(page.getJSONArray("data"));
  //noLoop();
}

void draw() {
  baseY = .7 * baseY + .3 * targetBaseY;
  noFill();
  stroke(255);
  background(0);
  
  Drawer drawer = new Drawer();
  drawer.addFrame(new Frame(0, 0, 100, 20));
  drawer.addFrame(new Frame(0, 0, 100, 30));
  drawer.addFrame(new Frame(0, 0, 100, 10));
  drawer.addFrame(new Frame(0, 0, 100, 40));
  drawer.addFrame(new Frame(0, 0, 100, 20));
  drawer.show(baseY);
  fill(255);
  
  LeveledPrinter printer = new LeveledPrinter();
  int i = 0;
  for (Word word : words) {
    //simpleAddWordToLeveledPrinter(word, printer, i++ == 1);
    complexAddWordToLeveledPrinter(word, printer);
  }
  printer.showAll();
  //printer.printAll();
}

void mouseWheel(MouseEvent event) {
  targetBaseY -= 10 * event.getCount();
}
