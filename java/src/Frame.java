import java.util.ArrayList;
import processing.core.PGraphics;
import processing.core.PConstants;

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
      if (hover)
         background = 50;
      else
         background = 0;
      if (popping) {
         background = popTime / 7 + 150 - context.papplet.millis() / 7;
         if (background < 0) {
            background = 0;
            popping = false;
         }
      }
      buffer.textAlign(PConstants.LEFT, PConstants.TOP);
      buffer.stroke(255);
      buffer.fill(background);
      buffer.background(background);
      buffer.rect(0, 0, width - 1, height - 1);
      buffer.fill(255);
      buffer.text(text, 3, 3);
   }
   void buffer() {
      buffer.beginDraw();
      drawToBuffer();
      for (Frame frame : subframes) {
         frame.buffer();
         buffer.image(frame.buffer, frame.posX, frame.posY);
      }
      buffer.endDraw();
   }
   Frame resolveClick(float ex, float ey) {
      if (!inFrame(ex, ey))
         return null;
      
      float localX = ex - posX;
      float localY = ey - posY;
      
      for (Frame frame : subframes) {
         if (frame.inFrame(localX, localY))
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
   void pop() {
      this.popTime = context.papplet.millis();
      popping = true;
   }
   void setHover(boolean hover) {
      this.hover = hover;
   }
}