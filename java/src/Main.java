import processing.core.PApplet;
import processing.data.JSONObject;
import processing.data.JSONArray;
import processing.core.*;

public class Main extends PApplet {
   JSONObject page;
   Word[] words;
   PFont renderFont;
   String pageURL = "https://jisho.org/api/v1/search/words?keyword=door";
   Context context;
   Frame frame;
   Frame clicked = null;
   Frame hover = null;
   public static void main(String[] args) {
      PApplet.main("Main");
   }
   public void settings() {
      size(200, 200);
   }
   public void setup() {
      //page = loadJSONObject(pageURL);
      //words = Word.loadFromJSONArray(page.getJSONArray("data"));
      textAlign(LEFT, TOP);
      renderFont = createFont("NotoSansMonoCJKjp-Regular.otf", 20);
      textFont(renderFont);
      context = new Context(this);
      frame = new Frame(context, "test", 60, 30);
      frame.subframes.add(new Frame(context, "foo", 25, 20));
   }
   public void draw() {
      background(40);
      //background(0);
      //stroke(255);
      //fill(255);
      //text(words[0].japanese[0] + words[0].senses[0].english_definitions[0], 10, 10);
      hover = frame.resolveClick(mouseX, mouseY);
      if (clicked != null)
         hover = clicked;
      if (hover != null)
         hover.setHover(true);
      frame.position(50, 70);
      frame.subframes.get(0).position(30, 5);
      stroke(255);
      frame.buffer();
      image(frame.buffer, frame.posX, frame.posY);
      if (hover != null)
         hover.setHover(false);
   }
   public void mousePressed() {
      clicked = frame.resolveClick(mouseX, mouseY);
      if (clicked != null)
         clicked.background = 100;
   }
   public void mouseReleased() {
      if (clicked != null && clicked == frame.resolveClick(mouseX, mouseY))
         clicked.pop();
      clicked = null;
   }
}