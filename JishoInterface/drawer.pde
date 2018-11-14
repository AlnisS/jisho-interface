class Drawer {
  ArrayList<Frame> frames;
  Drawer() {
    frames = new ArrayList<Frame>();
  }
  void addFrame(Frame frame) {
    frames.add(frame);
  }
  void show(float y) {
    for (Frame frame : frames) {
      frame.position(10, y);
      frame.show();
      y += frame.height;
    }
  }
}
