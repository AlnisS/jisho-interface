class Frame {
  float width;
  float height;
  float x;
  float y;
  Frame() {
    
  }
  Frame(float x, float y, float width, float height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }
  void position(float x, float y) {
    this.x = x;
    this.y = y;
  }
  void show() {
    rect(x, y, width, height);
  }
}
