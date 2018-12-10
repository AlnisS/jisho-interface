import java.util.ArrayList;
import processing.core.PGraphics;
import processing.core.PConstants;
import java.lang.Math;

public class Frame {
   float posX;
   float posY;
   int width;
   int height;
   PGraphics buffer;
   ArrayList<Frame> subframes;
   String text;
   Context context;
   int background;
   int popTime = 0;
   boolean popping = false;
   boolean hover;
   boolean show = true;
   Frame ref = null;
   public Frame(Context context, String text, int width, int height) {
      this.context = context;
      this.text = text;
      this.width = width;
      this.height = height;
      buffer = context.papplet.createGraphics(width, height);
      subframes = new ArrayList<>();
      background = 0;
   }
   void position(float x, float y) {
      this.posX = x;
      this.posY = y;
   }
   void drawToBuffer() {
      handleHover();
      handlePopping();
      setupDraw();
      drawFrame();
      drawText();
   }
   void setupDraw() {
      buffer.textAlign(PConstants.LEFT, PConstants.TOP);
      buffer.background(background);
      buffer.textFont(context.renderFont);
   }
   void drawFrame() {
      buffer.stroke(255);
      buffer.fill(background);
      buffer.rect(0, 0, width - 1, height - 1);
   }
   void drawText() {
      buffer.fill(255);
      buffer.text(text, 3, 3);
   }
   void buffer() {
      buffer.beginDraw();
      drawToBuffer();
      for (Frame frame : subframes) {
         if (frame.show) {
            frame.buffer();
            buffer.image(frame.buffer, frame.posX, frame.posY);
         }
      }
      buffer.endDraw();
   }
   Frame resolveClick(float ex, float ey) {
      if (!inFrame(ex, ey))
         return null;
      
      float localX = ex - posX;
      float localY = ey - posY;
      
      for (Frame frame : subframes) {
         if (frame.show && frame.inFrame(localX, localY))
            return frame.resolveClick(localX, localY);
      }
      return this;
   }
   boolean inFrame(float x, float y) {
      return x >= this.posX
          && x <  this.posX + this.width
          && y >= this.posY
          && y <  this.posY + this.height;
   }
   void setHover(boolean hover) {
      this.hover = hover;
   }
   void handleHover() {
      background = hover ? 50 : 0;
   }
   void pop() {
      this.popTime = context.papplet.millis();
      popping = true;
      if (ref != null)
         ref.show = !ref.show;
   }
   void handlePopping() {
      if (popping) {
         background = popTime / 7 + 150 - context.papplet.millis() / 7;
         if (background < 0) {
            background = 0;
            popping = false;
         }
      }
   }
}