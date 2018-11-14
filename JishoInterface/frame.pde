class Frame {
  float fwidth;
  float fheight;
  float x;
  float y;
  LeveledPrinter printer;
  Frame() {
    
  }
  Frame(LeveledPrinter printer, float x, float y, float fwidth, float fheight) {
    this.printer = printer;
    this.x = x;
    this.y = y;
    this.fwidth = fwidth;
    this.fheight = fheight;
    this.fheight = printer.strings.size() * 15;
  }
  void position(float x, float y) {
    this.x = x;
    this.y = y;
  }
  void show() {
    fill(0);
    noStroke();
    rect(x, y, fwidth, fheight);
    
    fill(255);
    printer.showAll(y);
  }
  void cr(int index, PGraphics cr) {
    cr.fill((index) | 0xFF000000);
    cr.noStroke();
    cr.rect(x, y, fwidth, fheight);
  }
  void highlight() {
    stroke(255);
    noFill();
    rect(x, y, fwidth, fheight);
  }
}
