import processing.core.PApplet;
import processing.core.PFont;

public class Context {
   public PApplet papplet;
   public PFont renderFont;
   public Context(PApplet papplet, PFont renderFont) {
      this.papplet = papplet;
      this.renderFont = renderFont;
   }
}