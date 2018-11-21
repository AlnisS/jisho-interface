import processing.data.JSONObject;

public class Link {
   public String text;
   public String url;
   public Link(JSONObject json) {
      this.text = json.getString("text");
      this.url = json.getString("url");
   }
   public String toString() {
      return text + ": " + url;
   }
}