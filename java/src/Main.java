import processing.core.PApplet;
import processing.data.JSONObject;
import processing.data.JSONArray;
import processing.core.*;

public class Main extends PApplet {
   JSONObject page;
   Word[] words;
   PFont renderFont;
   String pageURL = "https://jisho.org/api/v1/search/words?keyword=";
   Context context;
   Frame frame;
   Frame clicked = null;
   Frame hover = null;
   static String[] args;
   public static void main(String[] args_) {
      args = args_;
      if (args.length == 0)
         args = new String[] {"door"};
      PApplet.main("Main");
   }
   public void settings() {
      size(200, 200);
      //size(10, 10);
   }
   public void setup() {
      pageURL += args[0];
      page = loadJSONObject(pageURL);
      words = Word.loadFromJSONArray(page.getJSONArray("data"));
      textAlign(LEFT, TOP);
      renderFont = createFont("NotoSansMonoCJKjp-Regular.otf", 12);
      textFont(renderFont);
      context = new Context(this, renderFont);
      frame = new Frame(context, /*"test"*/
            words[0].japanese[0] + words[0].senses[0].english_definitions[0]
            , 100, 30);
      frame.subframes.add(new Frame(context, "foo", 25, 20));
      frame.subframes.add(new Frame(context, "bar", 25, 20));
      frame.ref = frame.subframes.get(0);
      frame.subframes.get(0).ref = frame.subframes.get(1);
      /*
      for (int j = 0; j < words.length; j++) {
         Word word = words[j];
         print(j + ". ");
         for (int i = 0; i < word.japanese.length; i++) {
            Japanese japanese = word.japanese[i];
            print(japanese.word + " (" + japanese.reading + ")");
            if (i < word.japanese.length - 1)
               print(", ");
         }
         println();
      }
      
      exit();
      */
   }
   
   public void draw() {
      background(40);
      background(0);
      stroke(255);
      fill(255);
      //text(words[0].japanese[0] + words[0].senses[0].english_definitions[0], 10, 10);
      hover = frame.resolveClick(mouseX, mouseY);
      if (clicked != null)
        hover = clicked;
      if (hover != null)
        hover.setHover(true);
      frame.position(50, 70);
      frame.subframes.get(0).position(30, 5);
      frame.subframes.get(1).position(60, 5);
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