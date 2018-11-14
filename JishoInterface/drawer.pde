class Drawer {
  ArrayList<Frame> frames;
  PGraphics clickResolver;
  Drawer() {
    frames = new ArrayList<Frame>();
  }
  void addFrame(Frame frame) {
    frames.add(frame);
  }
  void show(float y) {
    clickResolver = createGraphics(width, height);
    clickResolver.beginDraw();
    int i = 0;
    Frame hl = new Frame();
    for (Frame frame : frames) {
      frame.position(10, y);
      if (i == highlight)
        hl = frame;
      frame.show();
      frame.cr(i++, clickResolver);
      y += frame.fheight;
    }
    clickResolver.endDraw();
    hl.highlight();
  }
}
