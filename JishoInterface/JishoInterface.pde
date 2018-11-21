Word[] words;
float baseY = 0;
float targetBaseY = 0;
int expando = 0;
int highlight = 0;

void setup() {
  size(600, 600);
  println("loading...\n");
  JSONObject page = loadJSONObject("https://jisho.org/api/v1/search/words?keyword=door");
  words = loadFromJSONArray(page.getJSONArray("data"));
  println("done loading");
  textAlign(LEFT, TOP);
}

void draw() {
  baseY = .7 * baseY + .3 * targetBaseY;
  noFill();
  stroke(255);
  background(0);
  
  
  Drawer drawer = new Drawer();
  int i = 0;
  for (Word word : words) {
    LeveledPrinter printer = new LeveledPrinter();
    simpleAddWordToLeveledPrinter(word, printer, i++ == expando);
    drawer.addFrame(new Frame(printer, 0, 0, 100, 0));
  }
  drawer.show((int) baseY);
  //image(drawer.clickResolver, 0, 0);
  highlight = drawer.clickResolver.get(mouseX, mouseY) + 16777216;
}

void mouseWheel(MouseEvent event) {
  targetBaseY -= 10 * event.getCount();
}

void mousePressed() {
  expando = highlight;
}
